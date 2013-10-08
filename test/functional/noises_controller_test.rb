require 'test_helper'

class NoisesControllerTest < ActionController::TestCase
  setup do
    @noise = FactoryGirl.create(:noise)
  end

  teardown do
    sign_out
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:noises)
  end

  test "should show noise" do
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

    put :update, id: @noise, noise: { coordinates_latitude: @noise.coordinates_latitude, coordinates_longitude: @noise.coordinates_longitude, text: @noise.text, provider: @noise.provider, provider_id: @noise.provider_id }
    assert_redirected_to :root
  end

  test "admin should update noise" do
    sign_in(FactoryGirl.create(:admin_user))

    put :update, id: @noise, noise: { coordinates_latitude: @noise.coordinates_latitude, coordinates_longitude: @noise.coordinates_longitude, text: @noise.text, provider: @noise.provider, provider_id: @noise.provider_id }
    assert_redirected_to noise_path(assigns(:noise))
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

    assert_redirected_to noises_path
  end
end