namespace :carboncopy do
  desc "Back up the rails app via the backup gem"
  task :all do
    sh "backup perform --trigger carboncopy --config_file config/carboncopy.rb " # --data-path db --log-path log --tmp-path tmp
  end
end
