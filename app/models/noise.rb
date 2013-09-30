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

  def import_from_twitter_noise(twitter_noise, user)
    logger.info "Creating a noise from twitter noise: [#{twitter_noise.inspect}]" 
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
    import_from_twitter_noise(twitter_noise, user)
    save
  end

  def self.first_or_import_from_twitter_noise(twitter_noise, user) 
    Noise.where(:twitter_id => twitter_noise.id.to_s).first_or_create do |noise|
      noise.import_from_twitter_noise!(twitter_noise, user)
    end
  end

end
