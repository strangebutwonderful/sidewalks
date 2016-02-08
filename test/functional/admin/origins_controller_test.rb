require 'test_helper'

class Admin::OriginsControllerTest < ActionController::TestCase
  setup do
    @origin = FactoryGirl.create(:origin)
  end

  test 'should get index' do
    sign_in(FactoryGirl.create(:admin_user))

    get :index, noise_id: @origin.noise_id
    assert_response :success
    assert_not_nil assigns(:origins)
  end

  test 'should get new' do
    sign_in(FactoryGirl.create(:admin_user))

    get :new, noise_id: @origin.noise_id
    assert_response :success
  end

  test 'should create origin' do
    sign_in(FactoryGirl.create(:admin_user))

    assert_difference -> { Origin.count } do
      post :create, noise_id: @origin.noise_id, origin: { latitude: Faker::Address.latitude, longitude: Faker::Address.longitude }
      assert_not_nil assigns(:origin)
      assert_empty assigns(:origin).errors
    end

    assert_redirected_to admin_noise_origin_path(@origin.noise_id, assigns(:origin))
  end

  test 'should show origin' do
    sign_in(FactoryGirl.create(:admin_user))

    get :show, noise_id: @origin.noise_id, id: @origin
    assert_response :success
  end

  test 'should get edit' do
    sign_in(FactoryGirl.create(:admin_user))

    get :edit, noise_id: @origin.noise_id, id: @origin
    assert_response :success
  end

  test 'should update origin' do
    sign_in(FactoryGirl.create(:admin_user))

    put :update, noise_id: @origin.noise_id, id: @origin, origin: { latitude: @origin.latitude, longitude: @origin.longitude }
    assert_redirected_to admin_noise_origin_path(@origin.noise_id, assigns(:origin))
  end

  test 'should destroy origin' do
    sign_in(FactoryGirl.create(:admin_user))

    assert_difference -> { Origin.count }, -1 do
      delete :destroy, noise_id: @origin.noise_id, id: @origin
    end

    assert_redirected_to admin_noise_origins_path(@origin.noise_id)
  end
end
