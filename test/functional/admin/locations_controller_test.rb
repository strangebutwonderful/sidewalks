require 'test_helper'

class Admin::LocationsControllerTest < ActionController::TestCase
  setup do
    @location = FactoryGirl.create(:location, :san_francisco_city_hall)
    @user = FactoryGirl.create(:user)
  end

  test "FactoryGirl works" do
    assert_difference('Location.count') do
      FactoryGirl.create(:location)
    end
  end

  test "should get index" do
    sign_in(FactoryGirl.create(:admin_user))

    get :index
    assert_response :success
    assert_not_nil assigns(:locations)
  end

  test "should get new" do
    sign_in(FactoryGirl.create(:admin_user))

    get :new
    assert_response :success
  end

  test "should create location" do
    sign_in(FactoryGirl.create(:admin_user))

    assert_difference('Location.count') do
      VCR.use_cassette("functional/admin/locations_controller_test/create") do
        post(
          :create,
          location: {
            user_id: @user.id,
            address: @location.address,
            city: @location.city,
            state: @location.state,
            zip: @location.zip
          }
        )
      end
    end

    assert_redirected_to admin_location_path(assigns(:location))
  end

  test "should show location" do
    sign_in(FactoryGirl.create(:admin_user))

    get :show, id: @location
    assert_response :success
  end

  test "should get edit" do
    sign_in(FactoryGirl.create(:admin_user))

    get :edit, id: @location
    assert_response :success
  end

  test "should update location" do
    sign_in(FactoryGirl.create(:admin_user))

    put :update, id: @location, location: { address: @location.address, city: @location.city, latitude: @location.latitude, longitude: @location.longitude, state: @location.state, zip: @location.zip }
    assert_redirected_to admin_location_path(assigns(:location))
  end

  test "should destroy location" do
    sign_in(FactoryGirl.create(:admin_user))

    assert_difference('Location.count', -1) do
      delete :destroy, id: @location
    end

    assert_redirected_to admin_locations_path
  end
end
