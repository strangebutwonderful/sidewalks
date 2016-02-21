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

  IMAGE_EXTENSIONS = [
    ".bmp",
    ".gif",
    ".jfif",
    ".jpeg",
    ".jpg",
    ".png",
    ".tiff",
    ".webp"
  ].freeze

  pg_search_scope(
    :search_text,
    against: [:text],
    using: { tsearch: { dictionary: "english" } },
    associated_against: { user: :name }
  )

  belongs_to :user
  has_one :original, as: :importable, dependent: :destroy
  has_many :origins, -> { uniq true }, dependent: :destroy

  scope :where_nearby, ->(latitude, longitude, distance, created_at) do
    joins(:origins).
      merge(
        Origin.where_nearby(latitude, longitude, distance)
      ).
      where_since(created_at)
  end

  scope :where_needs_triage, ->(_params) do
    where(actionable: nil).order(created_at: :desc)
  end

  scope :where_actionable_or_not_triaged, -> do
    where(actionable: [true, nil])
  end

  scope :where_since, ->(time) do
    where("#{table_name}.created_at >= ?", time).order(created_at: :desc)
  end

  scope :where_authored_by_user_before, ->(user_id, time) do
    where(user_id: user_id).
      where("#{table_name}.created_at < ?", time).
      order(created_at: :desc)
  end

  scope :search, ->(params) do
    query = params[:q]
    if query.blank?
      none
    else
      search_text(params[:q]).where_since(1.week.ago)
    end
  end

  scope :explore_nearest, ->(latitude, longitude, distance, created_at) do
    where_nearby(latitude, longitude, distance, created_at).
      where_actionable_or_not_triaged.
      includes(:origins).
      includes(:original).
      includes(:user)
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
      with: URI.regexp(%w(http https)),
      allow_nil: true
    }
  )

  PROVIDER_SIDEWALKS = "sidewalks".freeze
  PROVIDER_TWITTER = "twitter".freeze

  delegate :name, :provider_url, to: :user, prefix: true, allow_nil: true
  delegate :url_helpers, to: "Rails.application.routes"

  def provider_url
    case provider
    when PROVIDER_TWITTER
      user && user.provider_url + "/status/" + provider_id
    else
      url_helpers.noise_path(self)
    end
  end

  def latlngs?
    origins.any?
  end

  def latlngs
    @latlngs ||= origins.map(&:latlng)
  end

  def map
    @map ||= Map.new(latlngs) if latlngs?
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

  def image_urls
    @image_urls ||= media_urls.select do |media_url|
      IMAGE_EXTENSIONS.include? File.extname(URI.parse(media_url).path).downcase
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
end
