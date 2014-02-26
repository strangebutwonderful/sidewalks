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
#

class User < ActiveRecord::Base
  delegate :url_helpers, to: 'Rails.application.routes' 

  rolify
  
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

  def has_coordinates?
    return !self.locations.empty?
  end

  def coordinates
    @coordinates ||= self.locations.map { |location| location.coordinates }
  end

  def map 
    @map ||= Map.new(self.coordinates)
  end  

  def update_credentials(auth)
    if auth['credentials']
      self.provider_access_token = auth['credentials']['token']
      self.provider_access_token_secret = auth['credentials']['secret']
      self.save!
    end
  end

  def import_from_twitter(twitter_user)
    logger.info "Creating a user from twitter noise: [#{twitter_user.inspect}]" 
    self.name = twitter_user.name || ""
    self.email = ""
    self.provider = User::PROVIDER_TWITTER
    self.provider_id = twitter_user.id.to_s
    self.provider_screen_name = twitter_user.screen_name || ""
    self.save!
  end

  def blank
    [:email, :provider_screen_name, :provider_access_token, :provider_access_token_secret].each do |attr|
      self[attr] = nil if self[attr].blank?
    end

    self
  end

  def self.providers
    providers = [User::PROVIDER_TWITTER]
  end

  def self.first_or_import_from_twitter(twitter_user) 
    User.where(:provider => User::PROVIDER_TWITTER, :provider_id => twitter_user.id.to_s).first_or_create do |user|
      user.import_from_twitter(twitter_user)
    end
  end

  def self.create_with_omniauth(auth)
    # See https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
    create! do |user|
      logger.info "Creating a user using omniauth: [#{auth.inspect}]" 
      user.provider = auth['provider']
      user.provider_id = auth['uid']
      if auth['info']
         user.name = auth['info']['name']
         user.email = auth['info']['email']
         user.provider_screen_name = auth['info']['nickname']
      end
    end
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
