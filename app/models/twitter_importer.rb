class TwitterImporter

  IMPORT_LOCK_KEY_NAME = 'twitter_noise_importer_lock'

  def self.twitter_client 
    @twitter_client ||= Twitter::REST::Client.new do |client_config|
      client_config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      client_config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      client_config.access_token = ENV['TWITTER_OAUTH_ACCESS_TOKEN']
      client_config.access_token_secret = ENV['TWITTER_OAUTH_ACCESS_TOKEN_SECRET']
    end
  end

  def self.import_latest_from_sidewalks_twitter
    # Import the latest noises from twitter and saves to db

    Rails.logger.debug "Begin importing from twitter"

    self.latest_tweets_from_sidewalks_twitter.reverse!.each do |tweet|
      user = User.first_or_create_from_twitter!(tweet.user, following: true)
      noise = Noise.first_or_create_from_tweet!(tweet, user)
    end

    Rails.logger.debug "Completed importing from twitter"
  end

  def self.import_connections
    TwitterImporter.twitter_client.friends.each do |twitter_user|
      User.first_or_create_from_twitter!(twitter_user, following: true)
    end
  end

  def self.gimme_a_tweet
    self.latest_tweets_from_sidewalks_twitter.first
  end

  private 

  def self.latest_tweets_from_sidewalks_twitter
    last_noise = Noise.where(provider: Noise::PROVIDER_TWITTER).last

    begin 
      if last_noise && last_noise.provider_id
        TwitterImporter.twitter_client.home_timeline({since_id: last_noise.provider_id})
      else
        TwitterImporter.twitter_client.home_timeline
      end
    rescue => exception
      Rails.logger.error exception
      return []
    end
  end  

end