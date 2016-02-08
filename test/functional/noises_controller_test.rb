require 'test_helper'

class NoisesControllerTest < ActionController::TestCase
  setup do
    @noises = FactoryGirl.create_list :noise, 5
  end

  teardown do
    Rails.cache.clear
    sign_out
  end

  test 'anyone should get index' do
    get :index
    assert_response(:success)
    assert_not_nil assigns(:noises)
  end

  test 'user should get index' do
    sign_in(FactoryGirl.create(:user))

    get :index
    assert_response(:success)
    assert_not_nil assigns(:noises)
  end

  test 'admin should get index' do
    sign_in(FactoryGirl.create(:admin_user))

    get :index
    assert_response(:success)
    assert_not_nil assigns(:noises)
  end

  test 'anyone should get explore' do
    get :explore
    assert_response(:success)
    assert_not_nil assigns(:noises)
  end

  test 'user should get explore' do
    sign_in(FactoryGirl.create(:user))

    get :explore
    assert_response(:success)
    assert_not_nil assigns(:noises)
  end

  test 'admin should get explore' do
    sign_in(FactoryGirl.create(:admin_user))

    get :explore
    assert_response(:success)
    assert_not_nil assigns(:noises)
  end

  test 'should show noise' do
    get :show, id: @noises.first
    assert_response(:success)
  end
end
