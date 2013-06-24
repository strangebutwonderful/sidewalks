class Tweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :coordinates_latitude, :coordinates_longitude, :text, :twitter_id

  def import(twitter_tweet)
    logger.info "Importing tweet: [#{twitter_tweet.inspect}]" 
    self.twitter_id = twitter_tweet.id.to_s
    self.text = twitter_tweet.text
    self.created_at = twitter_tweet.created_at

    # if twitter_tweet.coordinates
    #   self.coordinates_longitude = twitter_tweet.coordinates.coordinates[0]
    #   self.coordinates_latitude = twitter_tweet.coordinates.coordinates[1]
    # end
  end

  def import!(twitter_tweet) 
    import(twitter_tweet)
    save
  end

  def self.first_or_import(twitter_tweet) 
    Tweet.where(:twitter_id => twitter_tweet.id.to_s).first_or_create do |tweet|
      tweet.import(twitter_tweet)
    end
  end

  def self.first_or_import!(twitter_tweet) 
    Tweet.where(:twitter_id => twitter_tweet.id.to_s).first_or_create! do |tweet|
      tweet.import!(twitter_tweet)
    end
  end

end
