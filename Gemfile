source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '~> 3.2'
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier', '>= 1.0.3'
  gem 'yui-compressor'
end
gem 'compass-rails'
gem 'bootstrap-sass', '~> 2'
gem "font-awesome-sass", "~> 4"
gem 'cancan'
gem 'figaro'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'pg'
gem 'rolify'
gem 'thin'
gem 'twitter', '~> 4.8'
gem 'geocoder'
gem 'newrelic_rpm'
gem "leaflet-rails", "~> 0.7"
gem 'capistrano', '~> 3'
gem 'capistrano-rvm'
gem 'capistrano-bundler'
gem 'capistrano-rails', '~> 1.1'
gem "rails_autolink", '~> 1.1.5'
gem 'whenever', :require => false
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
end
group :test do 
  gem 'rake' # for travis
  gem 'mocha', :require => false
end
group :production do 
end

# For backups
# gem 'backup', '~> 4', :require => false