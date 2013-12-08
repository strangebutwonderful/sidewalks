require 'test_helper'

class OriginTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "FactoryGirl works" do
    assert_difference('Origin.count') do
      FactoryGirl.create(:origin)
    end
  end  
end
