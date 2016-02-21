module TwitterTranslators
  class TweetTranslator
    attr_reader :noises

    def self.translate(tweet_or_tweets)
      new.translate tweet_or_tweets
    end

    def initialize
      reset_noises
    end

    def translate(tweet_or_tweets)
      tweets =
        if tweet_or_tweets.respond_to?(:each)
          tweet_or_tweets
        else
          [tweet_or_tweets]
        end

      tweets.each do |tweet|
        user = UserTranslator.translate(tweet.user).first
        noises << find_or_create_noise_from_tweet(tweet, user)
      end

      noises
    end

    private

    def reset_noises
      @noises = []
    end

    def find_or_create_noise_from_tweet(tweet, user)
      Noise.find_by(
        provider: Noise::PROVIDER_TWITTER,
        provider_id: tweet.id.to_s
      ) || create_noise_from_tweet(tweet, user)
    end

    def create_noise_from_tweet(tweet, user)
      Rails.logger.info "Creating a noise from tweet: [#{tweet.to_yaml}]"

      noise = create_noise(tweet, user)
      translate_original(noise, tweet)
      translate_locations(noise, user.locations)
      translate_mentions_of_existing_users(noise, tweet.user_mentions)

      noise
    end

    def create_noise(tweet, user)
      Noise.create!(
        avatar_image_url: tweet.user.profile_image_uri_https.to_s,
        created_at: tweet.created_at,
        provider: Noise::PROVIDER_TWITTER,
        provider_id: tweet.id.to_s,
        text: tweet.full_text,
        user_id: user.id
      )
    end

    def translate_original(noise, tweet)
      noise.create_original!(dump: tweet.to_json)
    end

    def translate_locations(noise, locations)
      # TODO: get tweet"s embedded coordinates

      success_count = 0

      if locations.respond_to?(:each)
        locations.each do |location|
          next if noise.origins.exists?(
            latitude: location.latitude,
            longitude: location.longitude
          )
          noise.origins << location.to_origin
          success_count += 1
        end
      end

      success_count
    end

    def translate_mentions_of_existing_users(noise, tweet_user_mentions)
      success_count = 0
      if tweet_user_mentions.respond_to?(:each)
        tweet_user_mentions.each do |user_mention|
          mentioned_user = User.find_by(
            provider: Noise::PROVIDER_TWITTER,
            provider_id: user_mention.id.to_s
          )

          next unless mentioned_user
          success_count += translate_locations(
            noise,
            mentioned_user.locations
          )
        end
      end

      success_count
    end
  end
end
