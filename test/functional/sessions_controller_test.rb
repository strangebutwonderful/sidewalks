require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do

  end

  teardown do
    Rails.cache.clear
    sign_out
  end

  test "new should redirect to omniauth" do
    get :new
    assert_redirected_to '/auth/twitter'
  end

  test "destroy clears session user" do
    get :destroy
    assert_redirected_to :root
    assert_blank session[:user_id]
  end

  test "failure redirects to root" do
    get :failure
    assert_redirected_to :root
  end

end