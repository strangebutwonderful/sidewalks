require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should import on empty table" do 
    Noise.delete_all

    assert_difference('Noise.count', 20) do
      TwitterNoiseImporter.import_latest_from_sidewalks_twitter
    end
  end

  test "should import on non-empty table" do
    FactoryGirl.build(:noise)

    assert_difference('Noise.count', 20) do
      TwitterNoiseImporter.import_latest_from_sidewalks_twitter
    end
  end

end