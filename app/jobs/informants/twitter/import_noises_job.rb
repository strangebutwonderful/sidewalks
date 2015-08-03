module Informants::Twitter
  class ImportNoisesJob < ActiveJob::Base
    queue_as :default

    def perform()
      # Import the latest noises from twitter and saves to db
      Rails.logger.debug "Begin importing from twitter"

      latest_tweets = latest_tweets_from_sidewalks_twitter
      latest_tweets.reverse!.each do |tweet|
        user = User.first_or_create_from_twitter!(tweet.user, following: true)
        noise = Noise.first_or_create_from_tweet!(tweet, user)
      end

      Rails.logger.debug "Completed importing from twitter"
    end

    private

    def latest_tweets_from_sidewalks_twitter()
      last_noise = Noise.where(provider: Noise::PROVIDER_TWITTER).last

      if last_noise && last_noise.provider_id
        Sidewalks::Informants::Twitter.client.home_timeline(since_id: last_noise.provider_id)
      else
        Sidewalks::Informants::Twitter.client.home_timeline
      end
    end
  end
end
