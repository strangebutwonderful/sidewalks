require 'test_helper'

class NoisesControllerTest < ActionController::TestCase
  setup do
    @noise = FactoryGirl.create(:noise)
  end

  teardown do
    Rails.cache.clear
    sign_out
  end

  test "anyone should get index" do
    Twitter.expects(:home_timeline).returns([])

    get :index
    assert_response :success
    assert_not_nil assigns(:noises)
  end

  test "user should get index" do
    Twitter.expects(:home_timeline).returns([])

    sign_in(FactoryGirl.create(:user))

    get :index
    assert_response :success
    assert_not_nil assigns(:noises)
  end

  test "admin should get index" do
    Twitter.expects(:home_timeline).returns([])
    
    sign_in(FactoryGirl.create(:admin_user))

    get :index
    assert_response :success
    assert_not_nil assigns(:noises)
  end

  test "should show noise" do
    get :show, id: @noise
    assert_response :success
  end

end
