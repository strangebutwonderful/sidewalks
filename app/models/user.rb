# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string(255)      not null
#  email                        :string(255)
#  provider                     :string(255)      not null
#  provider_id                  :string(255)      not null
#  provider_screen_name         :string(255)
#  provider_access_token        :string(255)
#  provider_access_token_secret :string(255)
#  created_at                   :datetime
#  updated_at                   :datetime
#  following                    :boolean          default(FALSE), not null
#  locations_count              :integer          default(0), not null
#  mobile_venues_count          :integer
#

class User < ApplicationRecord
  delegate :url_helpers, to: "Rails.application.routes"

  rolify

  has_one :original, as: :importable
  has_many :locations, dependent: :destroy
  has_many :noises, -> { order(created_at: :desc) },
           dependent: :destroy

  validates_presence_of :name, :provider, :provider_id, :provider_screen_name

  PROVIDER_SIDEWALKS = "sidewalks".freeze
  PROVIDER_TWITTER = "twitter".freeze

  scope :order_by_name_ignore_case, -> { order("LOWER(name)") }
  scope :where_has_no_locations, -> { where(locations_count: [nil, 0]) }
  scope :where_has_no_mobile_venues, -> { where(mobile_venues_count: [nil, 0]) }
  scope :where_needs_triage, -> do
    where_has_no_locations.where_has_no_mobile_venues
  end

  def provider_url
    case provider
    when PROVIDER_TWITTER
      "https://twitter.com/" + provider_screen_name
    else
      url_helpers.user_path(self)
    end
  end

  def lat_lngs?
    locations.count > 0
  end

  def lat_lngs
    @lat_lngs ||= locations.map(&:lat_lng)
  end

  def map
    @map ||= Map.new(lat_lngs) if lat_lngs?
  end

  def update_credentials(auth)
    if auth["credentials"]
      self.provider_access_token = auth["credentials"]["token"]
      self.provider_access_token_secret = auth["credentials"]["secret"]
      save!
    end
  end

  def self.providers
    providers = [User::PROVIDER_TWITTER]
  end

  def self.create_from_omniauth!(auth)
    # See https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
    logger.info "Creating a user from omniauth: [#{auth.inspect}]"

    user = create! do |user|
      user.provider = auth["provider"]
      user.provider_id = auth["uid"]
      if auth["info"]
        user.name = auth["info"]["name"]
        user.email = auth["info"]["email"]
        user.provider_screen_name = auth["info"]["nickname"]
      end
    end

    user.create_original!(dump: auth.to_json)
    user
  end
end
