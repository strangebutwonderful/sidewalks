class Informants::Twitter::ImportUsersJob < ActiveJob::Base
  queue_as :default

  def perform
    Sidewalks::Informants::Twitter.client.friends.each do |twitter_user|
      User.first_or_create_from_twitter!(twitter_user, following: true)
    end
    Rails.logger.debug 'Imported twitter connections'
  end
end
