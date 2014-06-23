source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '~> 3.2'
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier', '>= 1.0.3'
  gem 'yui-compressor'
  gem 'jquery-rails', '~> 2.1'
  gem "compass", '~> 0.13.alpha.0'
  gem 'compass-rails', '>= 1.1.7'
  gem 'bootstrap-sass', '~> 2'
  gem 'font-awesome-sass', '~> 4'
end
gem 'cancan'
gem 'figaro'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'pg'
gem 'rolify'
gem 'thin'
gem 'pg_search'
gem 'exception_notification'
gem 'slack-notifier', '~> 0.4.0'
gem 'twitter', '~> 5'
gem 'geocoder'
gem 'leaflet-rails', '~> 0.7'
gem 'capistrano', '~> 3.2'
gem 'capistrano-rvm'
gem 'capistrano-bundler'
gem 'capistrano-rails', '~> 1.1'
gem 'rails_autolink', '~> 1.1.5'
gem 'whenever', '0.9.0', :require => false
gem 'flip', '~> 1'
group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end
group :development, :test do
  gem 'coveralls', require: false # code coverage
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'jasmine'
  gem 'webmock', require: false
  gem 'pry'
end
group :test do
  gem 'rake' # for travis
  gem 'mocha', :require => false
end
group :production do
  gem 'bugsnag'
  gem 'newrelic_rpm'
end

# For backups
gem 'replicate', '~> 1.5.1'
