# Importer
namespace :import do
  
  task :twitter => :environment do
    TwitterImporter.import_latest_from_sidewalks_twitter
  end

  task :twitter_accounts => :environment do
    TwitterImporter.import_followers
  end

end

task :import => ['import:twitter']