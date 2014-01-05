# Importer
namespace :import do
  
  task :twitter => :environment do
    TwitterNoiseImporter.import_latest_from_sidewalks_twitter
  end

  task :all => [:twitter]

end

