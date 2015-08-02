class TwitterImporter

  def self.import_latest_from_sidewalks_twitter
    # Import the latest noises from twitter and saves to db

    Rails.logger.debug "Begin importing from twitter"

    latest_tweets = latest_tweets_from_sidewalks_twitter
    latest_tweets.reverse!.each do |tweet|
      user = User.first_or_create_from_twitter!(tweet.user, following: true)
      noise = Noise.first_or_create_from_tweet!(tweet, user)
    end

    Rails.logger.debug "Completed importing from twitter"
  end

  def self.import_connections
    Sidewalks::Informants::Twitter.client.friends.each do |twitter_user|
      User.first_or_create_from_twitter!(twitter_user, following: true)
    end

    Rails.logger.debug "Imported twitter connections"
  end

  def self.latest_tweets_from_sidewalks_twitter
    last_noise = Noise.where(provider: Noise::PROVIDER_TWITTER).last

    if last_noise && last_noise.provider_id
      Sidewalks::Informants::Twitter.client.home_timeline(since_id: last_noise.provider_id)
    else
      Sidewalks::Informants::Twitter.client.home_timeline
    end
  end

end
