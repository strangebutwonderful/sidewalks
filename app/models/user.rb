class User < ActiveRecord::Base
  rolify
  has_many :noises
  attr_accessible :role_ids, :as => :admin
  attr_accessible :provider, :provider_id, :name, :email
  validates_presence_of :name

  attr_reader :provider_url

  PROVIDER_TWITTER = 'twitter'

  def provider_url
    "https://twitter.com/" + self.provider_screen_name
  end

  def import_from_twitter_noise_user(twitter_noise_user)
    logger.info "Creating a user from twitter noise: [#{twitter_noise_user.inspect}]" 
    self.name = twitter_noise_user.name || ""
    self.email = ""
    self.provider = User::PROVIDER_TWITTER
    self.provider_id = twitter_noise_user.id.to_s
    self.provider_screen_name = twitter_noise_user.screen_name || ""
    self.save!
  end

  def self.first_or_import_from_twitter_noise(twitter_noise_user) 
    User.where(:provider => User::PROVIDER_TWITTER, :provider_id => twitter_noise_user.id.to_s).first_or_create do |user|
      user.import_from_twitter_noise_user(twitter_noise_user)
    end
  end

  def self.create_with_omniauth(auth)
    # See https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
    create! do |user|
      logger.info "Creating a user using omniauth: [#{auth.inspect}]" 
      user.provider = auth['provider']
      user.provider_id = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.provider_screen_name = auth['info']['nickname'] || ""
      end
      if auth['credentials']
        user.provider_access_token = auth['credentials']['token']
        user.provider_access_token_secret = auth['credentials']['secret']
      end
    end
  end

end
