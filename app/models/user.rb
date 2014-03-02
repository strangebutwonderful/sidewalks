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
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  following                    :boolean          default(FALSE), not null
#  locations_count              :integer          default(0), not null
#

class User < ActiveRecord::Base
  delegate :url_helpers, to: 'Rails.application.routes' 

  rolify
  
  has_one :original, :as => :importable
  has_many :locations
  has_many :noises
  has_many :trails
  has_many :users
  
  attr_accessible :role_ids, :as => :admin
  attr_accessible :provider, :provider_id, :name, :email

  attr_reader :provider_url

  validates_presence_of :name, :provider, :provider_id, :provider_screen_name

  PROVIDER_SIDEWALKS = 'sidewalks'
  PROVIDER_TWITTER = 'twitter'

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
    [:email, :provider_screen_name, :provider_access_token, :provider_access_token_secret].each do |attribute|
      self[attribute] = nil if self[attribute].blank?
    end

    self
  end

  def self.providers
    providers = [User::PROVIDER_TWITTER]
  end

  def self.first_or_create_from_twitter!(twitter_user, following: true) 
    User.where(:provider => User::PROVIDER_TWITTER, :provider_id => twitter_user.id.to_s).first || User.create_from_twitter!(twitter_user, following: following)
  end  

  def self.create_from_omniauth!(auth)
    # See https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
    logger.info "Creating a user using omniauth: [#{auth.inspect}]" 
    
    user = create! do |user|
      user.provider = auth['provider']
      user.provider_id = auth['uid']
      if auth['info']
         user.name = auth['info']['name']
         user.email = auth['info']['email']
         user.provider_screen_name = auth['info']['nickname']
      end
    end

    user.create_original!(:dump => auth.to_json)
    user
  end

  def self.create_from_twitter!(twitter_user, following: false)
    logger.info "Creating a user from twitter noise: [#{twitter_user.inspect}]" 
    
    user = create! do |user|
      user.name = twitter_user.name
      user.provider = User::PROVIDER_TWITTER
      user.provider_id = twitter_user.id.to_s
      user.provider_screen_name = twitter_user.screen_name
      user.following = following
    end

    user.create_original!(:dump => twitter_user.to_json)
    user
  end

  def self.where_search(params)
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
