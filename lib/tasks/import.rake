# Importer
namespace :import do
  desc "Imports noises from Twitter tweets"
  task twitter: :environment do
    if Feature.on? :rake_import_twitter
      Informants::Twitter::ImportNoisesJob.perform_now
    else
      Rails.logger.debug "Import disabled, use `rake_import_tweets` "
    end
  end

  desc "Imports accounts from Twitter connections"
  task twitter_accounts: :environment do
    if Feature.on? :rake_import_twitter_accounts
      Informants::Twitter::ImportUsersJob.perform_now
    else
      Rails.logger.debug "Import disabled, use `rake_import_twitter_accounts` "
    end
  end
end

task import: ["import:twitter"]
