# See https://coveralls.io/docs/ruby
require 'coveralls'
Coveralls.wear!('rails')

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def sign_out
    @request.reset_session
    @current_user = nil
  end

  def build_twitter_user
    OpenStruct.new(
      :id => 'my_twitter_user_id',
      :name => 'my_twitter_user_name',
      :email => 'my_twitter_user_email@example.org',
      :screen_name => 'my_twitter_screen_name'
    )
  end

  def build_twitter_noise
    twitter_user = build_twitter_user

    OpenStruct.new(
      :id => 'my_twitter_noise_id',
      :text => 'my_twitter_noise_text',
      :created_at => Time.now,
      :user => twitter_user
    )
  end
end
