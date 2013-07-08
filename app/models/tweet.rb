class Tweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :coordinates_latitude, :coordinates_longitude, :text, :twitter_id

  def self.import_latest_from_sidewalks_twitter 
    # Import the latest tweets from twitter adn saves to db

    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_PROVIDER_KEY']
      config.consumer_secret = ENV['TWITTER_PROVIDER_SECRET']
      config.oauth_token = ENV['AJSHARMA_ACCESS_TOKEN']
      config.oauth_token_secret = ENV['AJSHARMA_ACCESS_TOKEN_SECRET']
    end

    @imported_tweets = Twitter.home_timeline
    @imported_tweets.each do |imported_tweet|
      user = User.first_or_import_from_twitter_tweet(imported_tweet)
      Tweet.first_or_import_from_twitter_tweet(imported_tweet, user)
    end    
  end

  def import_from_twitter_tweet(twitter_tweet, user)
    logger.info "import_from_twitter_tweeting tweet: [#{twitter_tweet.inspect}]" 
    self.twitter_id = twitter_tweet.id.to_s
    self.text = twitter_tweet.text
    self.created_at = twitter_tweet.created_at
    self.user_id = user.id

    # if twitter_tweet.coordinates
    #   self.coordinates_longitude = twitter_tweet.coordinates.coordinates[0]
    #   self.coordinates_latitude = twitter_tweet.coordinates.coordinates[1]
    # end
  end

  def import_from_twitter_tweet!(twitter_tweet, user) 
    import_from_twitter_tweet(twitter_tweet)
    save
  end

  def self.first_or_import_from_twitter_tweet(twitter_tweet, user) 
    Tweet.where(:twitter_id => twitter_tweet.id.to_s).first_or_create do |tweet|
      tweet.import_from_twitter_tweet(twitter_tweet, user)
    end
  end

end
