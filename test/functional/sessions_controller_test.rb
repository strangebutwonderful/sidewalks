require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => 'twitter',
      :uid => Faker::Number.number(10),
      :info => {
        :name => Faker::Name.name,
        :email => Faker::Internet.email,
        :nickname => Faker::Internet.user_name
      }
    })
  end

  teardown do
    Rails.cache.clear
    sign_out
    OmniAuth.config.test_mode = false
  end

  test "new should redirect to omniauth" do
    get :new
    assert_redirected_to '/auth/twitter'
  end

  test "create should redirect to root" do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]

    get :create, :provider => :twitter
    assert_redirected_to :root
    assert_not_nil session[:user_id]
  end

  test "destroy clears session user" do
    sign_in(FactoryGirl.create(:user))

    get :destroy
    assert_redirected_to :root
    assert_nil session[:user_id]
  end

  test "failure redirects to root" do
    get :failure
    assert_redirected_to :root
  end

end