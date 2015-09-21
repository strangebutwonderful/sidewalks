require "simplecov"
SimpleCov.start

if ENV["CI"] == "true"
  require "codecov"
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

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

# Include capybara
# See https://github.com/jnicklas/capybara#using-capybara-with-testunit
require "capybara/rails"

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end
