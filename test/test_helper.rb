# See https://coveralls.io/docs/ruby
require "coveralls"
Coveralls.wear!("rails")

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "pry"
require "mocha/setup"
require "vcr"

# Import test configurations/initializers
require "config/vcr"
require "config/initializers/action_controller/test_case"
require "config/initializers/active_support/test_case"
