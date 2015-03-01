namespace :feature do

  desc "Check if a feature flag is enabled"
  task :on?, [:flag] => :environment do |t, args|
    puts Feature.on? args.flag.to_sym
  end

  desc "Enable a feature flag"
  task :on, [:flag] => :environment do |t, args|
    puts Feature.on args.flag.to_sym
  end

  desc "Disable a feature flag"
  task :off, [:flag] => :environment do |t, args|
    puts Feature.off args.flag.to_sym
  end

  desc "Show list of features, does not currently support defaults"
  task :list => :environment do
    Feature.all.each do |feature|
      puts feature.key + ':' + feature.enabled
    end
  end

end