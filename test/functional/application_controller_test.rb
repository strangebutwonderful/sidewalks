require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test "current_user is nil if no user" do
    assert_nil current_user
  end

  test "current_user returns signed in user" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    assert_equal user, current_user
  end
end
