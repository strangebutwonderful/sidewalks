class Noise < ActiveRecord::Base
  belongs_to :user
  attr_accessible :coordinates_latitude, :coordinates_longitude, :text, :twitter_id

  attr_reader :provider_url, :user_name, :user_provider_url

  def provider_url
    self.user && self.user.provider_url + "/status/" + twitter_id
  end

  def user_name
    self.user && self.user.name
  end

  def user_provider_url
    self.user && self.user.provider_url
  end

  def self.import_latest_from_sidewalks_twitter 
    # Import the latest noises from twitter adn saves to db

    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token = ENV['TWITTER_OAUTH_ACCESS_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_OAUTH_ACCESS_TOKEN_SECRET']
    end

    @imported_noises = Twitter.home_timeline
    @imported_noises.each do |imported_noise|
      user = User.first_or_import_from_twitter_noise(imported_noise)
      Noise.first_or_import_from_twitter_noise(imported_noise, user)
    end    
  end

  def import_from_twitter_noise(twitter_noise, user)
    logger.info "import_from_twitter_noiseing noise: [#{twitter_noise.inspect}]" 
    self.twitter_id = twitter_noise.id.to_s
    self.text = twitter_noise.text
    self.created_at = twitter_noise.created_at
    self.user_id = user.id

    # if twitter_noise.coordinates
    #   self.coordinates_longitude = twitter_noise.coordinates.coordinates[0]
    #   self.coordinates_latitude = twitter_noise.coordinates.coordinates[1]
    # end
  end

  def import_from_twitter_noise!(twitter_noise, user) 
    import_from_twitter_noise(twitter_noise)
    save
  end

  def self.first_or_import_from_twitter_noise(twitter_noise, user) 
    Noise.where(:twitter_id => twitter_noise.id.to_s).first_or_create do |noise|
      noise.import_from_twitter_noise(twitter_noise, user)
    end
  end

end
