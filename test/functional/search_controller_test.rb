require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test 'anyone should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:noises)
  end

  test 'anyone should put index' do
    put :index
    assert_response :success
    assert_not_nil assigns(:noises)
  end

  test 'anyone should search index' do
    put :index, q: 'hello world'
    assert_response :success
    assert_not_nil assigns(:noises)
  end
end
