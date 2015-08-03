require 'test_helper'

class Informants::Twitter::ImportUsersJobTest < ActiveJob::TestCase

  test "should be able to import connections on an empty db" do
    Sidewalks::Informants::Twitter.client.expects(:friends).returns([])
    User.delete_all

    Informants::Twitter::ImportUsersJob.perform_now
  end

  test "should be able to import connections" do
    Sidewalks::Informants::Twitter.client.expects(:friends).returns([])
    FactoryGirl.build(:user)

    Informants::Twitter::ImportUsersJob.perform_now
  end

end
