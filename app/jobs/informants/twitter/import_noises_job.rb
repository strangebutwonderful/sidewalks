module Informants::Twitter
  class ImportNoisesJob < ActiveJob::Base
    queue_as :default

    def perform
      # Import the latest noises from twitter and saves to db
      Rails.logger.debug "Begin importing from twitter"
      TwitterTranslator.translate latest_tweets_from_sidewalks_twitter.reverse!
      Rails.logger.debug "Completed importing from twitter"
    end

    private

    def latest_tweets_from_sidewalks_twitter
      if last_imported_noise && last_imported_noise.provider_id.present?
        Sidewalks::Informants::Twitter.client.home_timeline(
          since_id: last_imported_noise.provider_id
        )
      else
        Sidewalks::Informants::Twitter.client.home_timeline
      end
    end

    def last_imported_noise
      @last_imported_noise = Noise.where(provider: Noise::PROVIDER_TWITTER).last
    end
  end
end
