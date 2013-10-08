require 'test_helper'

class NoisesControllerTest < ActionController::TestCase
  setup do
    # @noise = noises(:one)
    @noise = FactoryGirl.create(:noise)
    
    user = FactoryGirl.create(:user)
    sign_in(user)
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

  test "should get edit" do
    get :edit, id: @noise
    assert_response :success
  end

  test "should update noise" do
    put :update, id: @noise, noise: { coordinates_latitude: @noise.coordinates_latitude, coordinates_longitude: @noise.coordinates_longitude, text: @noise.text, provider: @noise.provider, provider_id: @noise.provider_id }
    assert_redirected_to noise_path(assigns(:noise))
  end

  test "should destroy noise" do
    assert_difference('Noise.count', -1) do
      delete :destroy, id: @noise
    end

    assert_redirected_to noises_path
  end
end
