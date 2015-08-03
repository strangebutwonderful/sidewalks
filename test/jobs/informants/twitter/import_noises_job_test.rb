require "test_helper"

class Informants::Twitter::ImportNoisesJobTest < ActiveJob::TestCase
  setup do
    Rails.cache.clear
  end

  test "should be able to import tweets on an empty db" do
    Sidewalks::Informants::Twitter.client.expects(:home_timeline).returns([])
    Noise.delete_all

    Informants::Twitter::ImportNoisesJob.perform_now
  end

  test "should import on non-empty table" do
    Sidewalks::Informants::Twitter.client.expects(:home_timeline).returns([])
    FactoryGirl.build(:noise) # ensure there's at least one noise

    Informants::Twitter::ImportNoisesJob.perform_now
  end
end
