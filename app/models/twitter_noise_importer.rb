class TwitterNoiseImporter

  IMPORT_LOCK_KEY_NAME = 'twitter_noise_importer_lock'

  def self.import_latest_from_sidewalks_twitter 
    # Import the latest noises from twitter and saves to db

    unless Rails.cache.exist?(TwitterNoiseImporter::IMPORT_LOCK_KEY_NAME)
      Rails.logger.debug "Begin importing from twitter"

      self.latest_noises_from_sidewalks_twitter.each do |tweet|
        begin
          user = User.first_or_import_from_twitter_noise_user(tweet.user)
          noise = Noise.first_or_import_from_twitter_noise(tweet, user)
          noise.import_locations(user.locations)

          self.import_mentions_of_existing_users(noise, tweet.user_mentions)
        rescue => exception
          Rails.logger.error exception
        end
      end

      Rails.cache.write(TwitterNoiseImporter::IMPORT_LOCK_KEY_NAME, true, expires_in: 5.minutes)
    end

    Rails.logger.debug "Completed importing from twitter"
  end

  def self.latest_noises_from_sidewalks_twitter
    last_noise = Noise.where(provider: Noise::PROVIDER_TWITTER).last

    begin 
      if last_noise && last_noise.provider_id
        Twitter.home_timeline({since_id: last_noise.provider_id})
      else
        Twitter.home_timeline
      end
    rescue => exception
      Rails.logger.error exception
      return []
    end
  end

  private 

  def self.import_mentions_of_existing_users(noise, user_mentions)
    user_mentions.each do |user_mention|
      mentioned_user = User.where(:provider => Noise::PROVIDER_TWITTER, :provider_id => user_mention.id.to_s).first
      if mentioned_user
        noise.import_locations(mentioned_user.locations)
      end
    end
  end

end