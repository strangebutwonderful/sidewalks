class User < ActiveRecord::Base
  rolify
  has_many :tweets
  attr_accessible :role_ids, :as => :admin
  attr_accessible :provider, :provider_id, :name, :email
  validates_presence_of :name

  def import_from_twitter_tweet(twitter_tweet)
    if(twitter_tweet.user)
      logger.info "user import_from_twitter_tweet: [#{twitter_tweet.inspect}]" 
      self.name = twitter_tweet.user.name || ""
      self.email = ""
      self.provider = 'twitter'
      self.provider_id = twitter_tweet.user.id.to_s
      self.provider_screen_name = twitter_tweet.user.screen_name || ""
      self.save!
    end
  end

  def self.first_or_import_from_twitter_tweet(twitter_tweet) 
    User.where(:provider_id => twitter_tweet.user.id.to_s).first_or_create do |user|
      user.import_from_twitter_tweet(twitter_tweet)
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.provider_id = auth['provider_id']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

end
