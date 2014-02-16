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
  delegate :url_helpers, to: 'Rails.application.routes' 

  belongs_to :user
  has_many :origins, uniq: true
  
  attr_accessible :text, :provider, :provider_id

  attr_reader :provider_url, :user_name, :user_provider_url, :map

  validates_presence_of :provider, :provider_id, :text, :created_at, :user_id

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

  def has_coordinates?
    return !self.origins.empty?
  end

  def coordinates
    @coordinates ||= self.origins.map { |origin| origin.coordinates }
  end

  def map 
    @map ||= Map.new(self.coordinates)
  end

  def import_from_twitter_noise(twitter_noise, user)
    logger.info "Creating a noise from twitter noise: [#{twitter_noise.inspect}]" 
    
    self.user_id = user.id

    self.provider = Noise::PROVIDER_TWITTER

    self.avatar_image_url = twitter_noise.try(:profile_image_url_https)
    self.created_at = twitter_noise.try(:created_at)
    self.provider_id = twitter_noise.try(:id).to_s
    self.text = twitter_noise.try(:text)

    save!
  end

  def import_locations(locations)
    # TODO: get tweet's embedded coordinates

    locations.each do |location|
      self.origins << location.to_origin
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
    params[:created_at] ||= 7.days.ago
    params[:distance] = 0.05

    where_nearby(params)
    .joins_origins
    .joins(:user).preload(:user) # cuz nearby overrides includes
  end

  def self.where_search_latest(params)
    params[:created_at] ||= 12.hours.ago

    where_nearby(params)
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
    distance = params[:distance] || 1

    if latitude && longitude
      search_location = [latitude, longitude]
    elsif location
      search_location = location
    end

    if search_location
      Rails.logger.debug "Location detected " + search_location.to_s

      # near(search_location, distance)
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
    where("#{table_name}.created_at >= ?", time)
  end

  def self.where_latest
    where_since(12.hours.ago).order("#{table_name}.created_at DESC")
  end

  def self.where_authored_by_user_since(user_id, noise_id)
    where(:user_id => user_id).
    where("#{table_name}.id < ?", noise_id)
  end


  def self.with_nearby_origins(params)
    joins(:origins)
      .preload(:origins)
      .merge(Origin.where_search(params))
  end

  def self.first_or_import_from_twitter_noise(twitter_noise, user) 
    where(:provider => Noise::PROVIDER_TWITTER, :provider_id => twitter_noise.id.to_s).first_or_create do |noise|
      noise.import_from_twitter_noise(twitter_noise, user)
    end
  end

end
