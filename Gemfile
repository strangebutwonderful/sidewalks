source "https://rubygems.org"
ruby "2.2.2"

gem "rails", "~> 4.2"

# assets

# css
gem "bootstrap-sass", "~> 3"
gem "compass-rails", "~> 2.0.4"
gem "font-awesome-sass", "~> 4"
gem "sass", "~> 3.4"
gem "sass-rails", "~> 5"

# javascript
gem "coffee-rails"
gem "uglifier", ">= 1.0.3"
gem "yui-compressor"
gem "jquery-rails", "~> 4.0"

# view helpers
gem "leaflet-rails", "~> 0.7"
gem "rails_autolink", "~> 1.1.5"

# authentication
gem "cancan"
gem "omniauth"
gem "omniauth-twitter"

# authorization
gem "rolify"

# env
gem "figaro"

# server
gem "pg"
gem "thin"

gem "pg_search"

gem "twitter", "~> 5"

gem "geocoder"

gem "whenever", "~> 0.9", require: false

gem "flip", "~> 1"

gem "capistrano", "~> 3.4"
gem "capistrano-bundler"
gem "capistrano-passenger"
gem "capistrano-rails", "~> 1.1"
gem "capistrano-rbenv"

# deprecated controller actions
gem "responders", "~> 2.0"

group :development do
  gem "annotate"
  gem "guard-bundler"
  gem "guard-rails"
  gem "spring"
end

group :development, :test do
  gem "coveralls", require: false # code coverage
  gem "factory_girl_rails"
  gem "faker"
  gem "jasmine"
  gem "pry"
  gem "rails-perftest"
  gem "ruby-prof"
  gem "web-console", "~> 2.0"
  gem "webmock", require: false
end

group :test do
  gem "rake" # for travis
  gem "mocha", require: false
  gem "vcr"
end

group :production do
  gem "bugsnag"
  gem "newrelic_rpm"
end

# For backups
gem "replicate", "~> 1.5.1"
