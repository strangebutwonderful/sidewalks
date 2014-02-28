require 'test_helper'

class TwitterImporterTest < ActiveSupport::TestCase

  setup do
    Rails.cache.clear
  end

  test "should be able to import tweets on an empty db" do 
    Twitter.expects(:home_timeline).returns([])
    Noise.delete_all

    TwitterImporter.import_latest_from_sidewalks_twitter
  end

  test "should import on non-empty table" do
    Twitter.expects(:home_timeline).returns([])
    FactoryGirl.build(:noise) # ensure there's at least one noise 

    TwitterImporter.import_latest_from_sidewalks_twitter
  end

  test "should return empty list on exception" do
    Twitter.expects(:home_timeline).raises

    TwitterImporter.import_latest_from_sidewalks_twitter
  end

  test "should be able to import connections on an empty db" do
    Twitter.expects(:friends).returns([])
    User.delete_all

    TwitterImporter.import_connections
  end

  test "should be able to import connections" do
    Twitter.expects(:friends).returns([])
    FactoryGirl.build(:user)

    TwitterImporter.import_connections
  end
end