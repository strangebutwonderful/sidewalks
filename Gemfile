source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '~> 4.2'

# assets

# css
gem 'bootstrap-sass', '~> 3'
gem 'compass-rails', '~> 2.0.4'
gem 'font-awesome-sass', '~> 4'
gem 'sass', '~> 3.4'
gem 'sass-rails', '~> 5'

# javascript
gem 'coffee-rails'
gem 'uglifier', '>= 1.0.3'
gem 'yui-compressor'
gem 'jquery-rails', '~> 4.0'

# view helpers
gem 'leaflet-rails', '~> 0.7'
gem 'rails_autolink', '~> 1.1.5'

# authentication
gem 'cancan'
gem 'omniauth'
gem 'omniauth-twitter'

# authorization
gem 'rolify'

# env
gem 'figaro'

# server
gem 'pg'
gem 'puma'

gem 'rack-attack'
gem 'rack-timeout'

gem 'pg_search'

gem 'twitter', '~> 5'

gem 'geocoder'

gem 'clockwork', require: false

gem 'flip', '~> 1'

# DevOps tools
gem 'rack-mini-profiler'
gem 'flamegraph'
gem 'stackprof'

# For backups
gem 'replicate', '~> 1.5.1'

# Deployments
gem 'capistrano', '~> 3.4'
gem 'capistrano-bundler'
gem 'capistrano-passenger'
gem 'capistrano-rails', '~> 1.1'
gem 'capistrano-rbenv'
gem 'capistrano-rails-console'

# deprecated controller actions
gem 'responders', '~> 2.0'

group :development do
  gem 'annotate'
  gem 'spring'
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'codecov', require: false # code coverage
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'guard', require: false
  gem 'guard-minitest', require: false
  gem 'pry'
  gem 'rubocop'
  gem 'webmock', require: false
end

group :test do
  gem 'capybara'
  gem 'climate_control'
  gem 'mocha', require: false
  gem 'rails-controller-testing' # for `assigns` and `assert_template`
  gem 'rake' # for travis
  gem 'vcr'
end

group :production do
  gem 'bugsnag'
  gem 'newrelic_rpm'
  gem 'rails_12factor'
  gem 'skylight'
end
