require 'test_helper'

class TwitterNoiseImporterTest < ActiveSupport::TestCase

  setup do
    Rails.cache.clear
  end

  test "should import on empty table" do 
    Twitter.expects(:home_timeline).returns([])
    Noise.delete_all

    TwitterNoiseImporter.import_latest_from_sidewalks_twitter
  end

  test "should import on non-empty table" do
    Twitter.expects(:home_timeline).returns([])
    FactoryGirl.build(:noise) # ensure there's at least one noise 

    TwitterNoiseImporter.import_latest_from_sidewalks_twitter
  end

  test "should return empty list on exception" do
    Twitter.expects(:home_timeline).raises

    TwitterNoiseImporter.import_latest_from_sidewalks_twitter
  end
end