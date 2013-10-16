class TwitterNoiseImporter

  def self.configure 
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token = ENV['TWITTER_OAUTH_ACCESS_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_OAUTH_ACCESS_TOKEN_SECRET']
    end
  end

  def self.import_latest_from_sidewalks_twitter 
    # Import the latest noises from twitter adn saves to db

    self.latest_noises_from_sidewalks_twitter.each do |imported_noise|
      user = User.first_or_import_from_twitter_noise_user(imported_noise.user)
      Noise.first_or_import_from_twitter_noise(imported_noise, user)
    end
  end

  def self.latest_noises_from_sidewalks_twitter
    self.configure

    last_noise = Noise.last

    if last_noise && last_noise.provider_id
      Twitter.home_timeline({since_id: last_noise.provider_id})
    else
      Twitter.home_timeline
    end
  end

end