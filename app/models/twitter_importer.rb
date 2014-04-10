require_relative '../services/twitter_service'

class TwitterImporter

  IMPORT_LOCK_KEY_NAME = 'twitter_noise_importer_lock'

  def self.import_latest_from_sidewalks_twitter
    # Import the latest noises from twitter and saves to db

    Rails.logger.debug "Begin importing from twitter"

    latest_tweets = self.latest_tweets_from_sidewalks_twitter
    latest_tweets.reverse!.each do |tweet|
      user = User.first_or_create_from_twitter!(tweet.user, following: true)
      noise = Noise.first_or_create_from_tweet!(tweet, user)
    end

    Rails.logger.debug "Completed importing from twitter"
  end

  def self.import_connections
    TwitterService.client.friends.each do |twitter_user|
      User.first_or_create_from_twitter!(twitter_user, following: true)
    end

    Chatterbox.tell "Imported twitter connections"
  end

  def self.gimme_a_tweet
    self.latest_tweets_from_sidewalks_twitter.first
  end

  private 

  def self.latest_tweets_from_sidewalks_twitter
    last_noise = Noise.where(provider: Noise::PROVIDER_TWITTER).last

    begin 
      if last_noise && last_noise.provider_id
        TwitterService.client.home_timeline({since_id: last_noise.provider_id})
      else
        TwitterService.client.home_timeline
      end
    rescue => exception
      Rails.logger.error exception
      return []
    end
  end  

end