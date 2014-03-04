# == Schema Information
#
# Table name: noises
#
#  id               :integer          not null, primary key
#  provider_id      :string(255)      not null
#  user_id          :integer          not null
#  text             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  provider         :string(255)      not null
#  avatar_image_url :string(255)
#
# Indexes
#
#  index_noises_on_user_id  (user_id)
#

class Noise < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search_text, against: [:text],
    using: {tsearch: {dictionary: "english"}},
    associated_against: { user: :name }

  scope :none, where('1 = 0')

  delegate :url_helpers, to: 'Rails.application.routes' 

  belongs_to :user
  has_one :original, as: :importable, dependent: :destroy
  has_many :origins, uniq: true, dependent: :destroy

  replicate_associations :origins # for replicate gem
  
  attr_accessible :text, :provider, :provider_id

  attr_reader :provider_url, :user_name, :user_provider_url, :map

  validates_presence_of :provider, :provider_id, :text, :created_at, :user_id

  validates_format_of :avatar_image_url, :with => URI.regexp(['http', 'https']), :allow_nil => true

  PROVIDER_SIDEWALKS = 'sidewalks'
  PROVIDER_TWITTER = 'twitter'

  def provider_url
    case provider
    when PROVIDER_TWITTER
      self.user && self.user.provider_url + "/status/" + provider_id
    else
      url_helpers.noise_path(self)
    end
  end

  def user_name
    self.user && self.user.name
  end

  def user_provider_url
    self.user && self.user.provider_url
  end

  def latlngs?
    self.origins.any?
  end

  def latlngs
    @latlngs ||= self.origins.map { |origin| origin.latlng }
  end

  def map 
    @map ||= Map.new(self.latlngs) if self.latlngs?
  end

  def self.create_from_tweet!(tweet, user)
    logger.info "Creating a noise from tweet: [#{tweet.inspect}]" 
    
    noise = create! do |noise|
      noise.avatar_image_url = tweet.user.profile_image_uri_https.to_s
      noise.created_at = tweet.created_at
      noise.provider = Noise::PROVIDER_TWITTER
      noise.provider_id = tweet.id.to_s
      noise.text = tweet.full_text
      noise.user_id = user.id
    end

    noise.create_original!(:dump => tweet.to_json)

    noise.import_locations(user.locations)
    noise.import_locations_from_mentions_of_existing_users(tweet.user_mentions)

    noise
  end

  def import_locations(locations)
    # TODO: get tweet's embedded coordinates

    success_count = 0

    if locations.present?
      locations.each do |location|
        self.origins << location.to_origin
        success_count = success_count + 1
      end
    end

    success_count
  end

  def import_locations_from_mentions_of_existing_users(tweet_user_mentions)
    success_count = 0
    if tweet_user_mentions.present?
      tweet_user_mentions.each do |user_mention|
        mentioned_user = User.where(:provider => Noise::PROVIDER_TWITTER, :provider_id => user_mention.id.to_s).first
        if mentioned_user
          success_count += import_locations(mentioned_user.locations)
        end
      end
    end

    success_count
  end

  def self.search(params)
    query = params[:q]
    unless query.blank?
      self.search_text(params[:q]).where_since(1.week.ago)
    else
      self.none # Needs to be updated in rails 4 to use none query and avoid db altogether
    end
  end

  def self.where_grouped_search(params)
    @noises = Noise.where_search(params)

    @noises = @noises.group_by do |noise|
      noise.user_id
    end

    @noises
  end

  def self.where_search(params)
    Noise.where_search_nearest(params).all + Noise.where_search_latest(params).all
  end

  def self.where_search_nearest(params)
    search_params = params.clone
    search_params[:created_at] ||= 7.days.ago
    search_params[:distance] = 0.025

    where_nearby(search_params)
    .joins_origins
    .joins(:user).preload(:user) # cuz nearby overrides includes
  end

  def self.where_search_latest(params)
    search_params = params.clone
    search_params[:created_at] ||= 12.hours.ago

    where_nearby(search_params)
    .where_latest
    .joins_origins
    .joins(:user).preload(:user) # cuz nearby overrides includes
  end

  def self.joins_origins
    joins("LEFT OUTER JOIN #{Origin.table_name} ON #{table_name}.id = #{Origin.table_name}.noise_id").preload(:origins) # cuz nearby overrides includes
  end

  def self.where_ids(ids) 
    unless ids.nil?
      where(:id => ids)
    else
      scoped
    end
  end

  def self.where_nearby(params)
    location = params[:location]
    latitude = params[:latitude]
    longitude = params[:longitude]

    if latitude && longitude
      search_location = [latitude, longitude]
    elsif location
      search_location = location
    end

    if search_location
      Rails.logger.debug "Location detected " + search_location.to_s

      noise_ids = Origin.where_search(params).where_since(params[:created_at]).pluck(:noise_id)
      where_ids(noise_ids)
      .order_by_ids(noise_ids)
    else
      scoped
    end
  end

  def self.order_by_ids(ids) 
    order_by = ids.map { |id| "#{table_name}.id = #{id} DESC" }
    order_by = order_by.join(", ")
    order(order_by)
  end

  def self.where_since(time)
    where("#{table_name}.created_at >= ?", time).order("#{table_name}.created_at DESC")
  end

  def self.where_latest
    where_since(12.hours.ago)
  end

  def self.where_authored_by_user_before(user_id, time)
    where(:user_id => user_id)
      .where("#{table_name}.created_at < ?", time)
      .order("#{table_name}.created_at DESC")
  end

  def self.where_authored_by_user_since(user_id, time)
    where(:user_id => user_id)
      .where("#{table_name}.created_at > ?", time)
      .order("#{table_name}.created_at ASC")
  end

  def self.with_nearby_origins(params)
    joins(:origins)
      .preload(:origins)
      .merge(Origin.where_search(params))
  end

  def self.first_or_create_from_tweet!(tweet, user) 
    Noise.where(:provider => Noise::PROVIDER_TWITTER, :provider_id => tweet.id.to_s).first || Noise.create_from_tweet!(tweet, user)
  end  

end
