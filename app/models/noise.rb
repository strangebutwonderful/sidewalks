# == Schema Information
#
# Table name: noises
#
#  id               :integer          not null, primary key
#  provider_id      :string(255)      not null
#  user_id          :integer          not null
#  text             :text             not null
#  created_at       :datetime
#  updated_at       :datetime
#  provider         :string(255)      not null
#  avatar_image_url :string(255)
#  actionable       :boolean
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

  belongs_to :user
  has_one :original, as: :importable, dependent: :destroy
  has_many :origins, ->{ uniq true },
    dependent: :destroy

  scope :where_nearby, ->(params) do
    joins(:origins).
      merge(Origin.where_nearby(params)).
      where_since(params[:created_at])
  end

  scope :where_needs_triage, ->(params) do
    where(actionable: nil).order(created_at: :desc)
  end

  scope :where_actionable_or_not_triaged, -> do
    where(actionable: [true, nil])
  end

  scope :where_since, ->(time) do
    where("#{table_name}.created_at >= ?", time).order(created_at: :desc)
  end

  scope :where_latest, -> do
    where_since 12.hours.ago
  end

  scope :where_authored_by_user_before, ->(user_id, time) do
    where(user_id: user_id).
      where("#{table_name}.created_at < ?", time).
      order(created_at: :desc)
  end

  replicate_associations :origins # for replicate gem

  attr_reader :provider_url, :user_name, :user_provider_url, :map

  validates(
    :created_at,
    :provider,
    :text,
    :user,
    presence: true
  )

  validates(
    :avatar_image_url,
    format: {
      with: URI.regexp(["http", "https"]),
      allow_nil: true
    }
  )

  PROVIDER_SIDEWALKS = "sidewalks"
  PROVIDER_TWITTER = "twitter"

  delegate :name, :provider_url, to: :user, prefix: true, allow_nil: true
  delegate :url_helpers, to: "Rails.application.routes"

  def provider_url
    case provider
    when PROVIDER_TWITTER
      self.user && self.user.provider_url + "/status/" + provider_id
    else
      url_helpers.noise_path(self)
    end
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

  def actionablity_upvotable?
    actionable != true
  end

  def actionablity_downvotable?
    actionable != false
  end

  def actionablity_resetable?
    !actionable.nil?
  end

  ###
  # Pull media objects out of noise
  # Media object format:
  # id: string
  # id_str: string
  # indicies: [int, int]
  # media_url: http://pbs.twimg.com/media/BlDRfNDCUAAKxLW.jpg
  # media_url_https: https://pbs.twimg.com/media/BlDRfNDCUAAKxLW.jpg
  # url: http://t.co/3QILJLen8A
  # display_url: pic.twitter.com/3QILJLen8A
  # expanded_url: http://twitter.com/humphryslocombe/status/455093899820691456/photo/1
  # type: photo
  # sizes: {"thumb"=>{"w"=>150, "h"=>150, "resize"=>"crop"}, "small"=>{"w"=>340, "h"=>453, "resize"=>"fit"}, "medium"=>{"w"=>600, "h"=>800, "resize"=>"fit"}, "large"=>{"w"=>768, "h"=>1024, "resize"=>"fit"}}
  ###
  def media_entities
    @media_entities ||= begin
      me = if Noise::PROVIDER_TWITTER == provider
        try(:original).
        try(:dump).
        try(:[], "entities").
        try(:[], "media")
      end
      me ||= {}
      me
    end
  end

  def url_entities
    @url_entities ||= begin
      me = if Noise::PROVIDER_TWITTER == provider
        try(:original).
        try(:dump).
        try(:[], "entities").
        try(:[], "urls")
      end
      me ||= {}
      me
    end
  end

  def media_urls
    @media_urls ||= local_media_urls + external_media_urls
  end

  def local_media_urls
    @local_media_urls ||= media_entities.map do |m|
      m.try(:[], "media_url_https") || m.try(:[], "media_url_http")
    end
  end

  def external_media_urls
    @external_media_urls ||= begin
      urls = url_entities.map { |m| m.try(:[], "expanded_url") }
      media_urls = urls.map do |url|
        if url.start_with?("http://instagram.com/", "https://instagram.com/")
          url += "media/?size=l"
        end
        url
      end
      media_urls.compact!
      media_urls
    end
  end

  def self.search(params)
    query = params[:q]
    unless query.blank?
      self.search_text(params[:q]).where_since(1.week.ago)
    else
      self.none # Needs to be updated in rails 4 to use none query and avoid db altogether
    end
  end

  def self.explore_and_group(params)
    @noises = Noise.explore(params)

    @noises = @noises.group_by do |noise|
      noise.user_id
    end

    @noises
  end

  def self.explore(params)
    Noise.explore_nearest(params).all
  end

  def self.explore_nearest(params = [])
    search_params = params.clone
    search_params[:created_at] ||= 7.days.ago

    where_nearby(search_params).
      where_actionable_or_not_triaged.
      includes(:origins).
      includes(:original).
      includes(:user)
  end

end
