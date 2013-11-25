require 'test_helper'

class Admin::NoisesControllerTest < ActionController::TestCase
  setup do
    @noise = FactoryGirl.create(:noise)
  end

  teardown do
    Rails.cache.clear
    sign_out
  end

  test "anyone should not get index" do
    get :index
    assert_redirected_to :root
  end

  test "user should not get index" do
    sign_in(FactoryGirl.create(:user))

    get :index
    assert_redirected_to :root
  end

  test "admin should get index" do    
    sign_in(FactoryGirl.create(:admin_user))

    get :index
    assert_response :success
    assert_not_nil assigns(:noises)
  end

  test "anyone should see noise" do
    get :show, id: @noise
    assert_redirected_to :root
  end

  test "user should not see noise" do
    sign_in(FactoryGirl.create(:user))

    get :show, id: @noise
    assert_redirected_to :root
  end

  test "admin should see noise" do    
    sign_in(FactoryGirl.create(:admin_user))

    get :show, id: @noise
    assert_response :success
  end

  test "user should not get edit" do
    sign_in(FactoryGirl.create(:user))

    get :edit, id: @noise
    assert_redirected_to :root
  end

  test "admin should get edit" do
    sign_in(FactoryGirl.create(:admin_user))

    get :edit, id: @noise
    assert_response :success
  end

  test "user should not update noise" do
    sign_in(FactoryGirl.create(:user))

    put :update, id: @noise, noise: { latitude: @noise.latitude, longitude: @noise.longitude, text: @noise.text, provider: @noise.provider, provider_id: @noise.provider_id }
    assert_redirected_to :root
  end

  test "admin should update noise" do
    sign_in(FactoryGirl.create(:admin_user))

    put :update, id: @noise, noise: { latitude: @noise.latitude, longitude: @noise.longitude, text: @noise.text, provider: @noise.provider, provider_id: @noise.provider_id }
    assert_redirected_to admin_noise_path(assigns(:noise))
  end

  test "user should not destroy noise" do
    sign_in(FactoryGirl.create(:user))

    assert_no_difference('Noise.count') do
      delete :destroy, id: @noise
    end

    assert_redirected_to :root
  end

  test "admin should destroy noise" do
    sign_in(FactoryGirl.create(:admin_user))

    assert_difference('Noise.count', -1) do
      delete :destroy, id: @noise
    end

    assert_redirected_to admin_noises_path
  end
end
