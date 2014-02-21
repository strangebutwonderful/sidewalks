require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "anyone should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:noises)
  end
    
end
