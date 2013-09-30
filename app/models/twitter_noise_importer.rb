class TwitterNoiseImporter

  def self.import_latest_from_sidewalks_twitter 
    # Import the latest noises from twitter adn saves to db

    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token = ENV['TWITTER_OAUTH_ACCESS_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_OAUTH_ACCESS_TOKEN_SECRET']
    end

    imported_noises = Twitter.home_timeline
    imported_noises.each do |imported_noise|
      user = User.first_or_import_from_twitter_noise(imported_noise)
      Noise.first_or_import_from_twitter_noise(imported_noise, user)
    end
  end

end