require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test 'current_user returns signed in user' do
    user = FactoryGirl.create(:user)
    sign_in(user)

    assert_equal session[:user_id], user.id
  end
end
