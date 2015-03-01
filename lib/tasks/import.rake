# Importer
namespace :import do

  task :twitter => :environment do
    if Feature.on? :rake_import_twitter
      TwitterImporter.import_latest_from_sidewalks_twitter
    else
      Rails.logger.debug "Import disabled, use `rake_import_tweets` "
    end
  end

  task :twitter_accounts => :environment do
    if Feature.on? :rake_import_twitter_accounts
      TwitterImporter.import_connections
    else
      Rails.logger.debug "Import disabled, use `rake_import_twitter_accounts` "
    end
  end

end

task :import => ['import:twitter']