namespace :feature do

  desc "Check if a feature flag is enabled"  
  task :on?, [:flag] => :environment do |t, args|
    puts Feature.on? args.flag.to_sym
  end

  desc "Turn a feature flag on"  
  task :on, [:flag] => :environment do |t, args|
    puts Feature.on args.flag.to_sym
  end

  desc "Turn a feature flag off"  
  task :off, [:flag] => :environment do |t, args|
    puts Feature.off args.flag.to_sym
  end

end