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

class User < ActiveRecord::Base
  delegate :url_helpers, to: 'Rails.application.routes'

  rolify

  has_one :original, as: :importable
  has_many :locations, dependent: :destroy
  has_many :noises, -> { order( created_at: :desc ) },
    dependent: :destroy
  has_many :trails, dependent: :destroy

  attr_reader :provider_url

  validates_presence_of :name, :provider, :provider_id, :provider_screen_name

  PROVIDER_SIDEWALKS = 'sidewalks'
  PROVIDER_TWITTER = 'twitter'

  scope :where_needs_triage, -> (params = {}) do
    where(
      arel_table[:locations_count].lt(1).
      or(
        arel_table[:mobile_venues_count].lt(1)
      )
    )
  end

  def provider_url
    case provider
    when PROVIDER_TWITTER
      "https://twitter.com/" + self.provider_screen_name
    else
      url_helpers.user_path(self)
    end
  end

  def latlngs?
    self.locations.any?
  end

  def latlngs
    @latlngs ||= self.locations.map { |location| location.latlng }
  end

  def map
    @map ||= Map.new(self.latlngs) if self.latlngs?
  end

  def update_credentials(auth)
    if auth['credentials']
      self.provider_access_token = auth['credentials']['token']
      self.provider_access_token_secret = auth['credentials']['secret']
      self.save!
    end
  end

  def blank
    [
      :email,
      :provider_access_token,
      :provider_access_token_secret,
      :provider_screen_name,
    ].each do |attribute|
      self[attribute] = nil if self[attribute].blank?
    end

    self
  end

  def self.providers
    providers = [User::PROVIDER_TWITTER]
  end

  def self.create_from_omniauth!(auth)
    # See https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
    logger.info "Creating a user from omniauth: [#{auth.inspect}]"

    user = create! do |user|
      user.provider = auth['provider']
      user.provider_id = auth['uid']
      if auth['info']
         user.name = auth['info']['name']
         user.email = auth['info']['email']
         user.provider_screen_name = auth['info']['nickname']
      end
    end

    user.create_original!(dump: auth.to_json)
    user
  end

  def self.explore(params)
    order = params[:order]

    if order && order.casecmp('name') == 0
      self.order_by_name_ignore_case
    elsif order
      self.order(order)
    else
      self.order('id')
    end
  end

  def self.order_by_name_ignore_case
    self.order('lower(name)')
  end

end
