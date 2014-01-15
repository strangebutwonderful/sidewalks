require 'test_helper'

class MapTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "FactoryGirl works" do
    assert_not_nil FactoryGirl.build(:map)
  end

  test "Boundaries not null" do
    assert_not_nil FactoryGirl.build(:map).boundaries
  end  

end