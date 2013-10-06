require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "FactoryGirl works" do
    assert_difference('User.count') do
      FactoryGirl.create(:user)
    end
  end

  test "imports raw twitter object" do
    twitter_user = build_twitter_user

    user = User.new

    assert user.import_from_twitter_noise_user(twitter_user)
  end

  test "imports user when new user" do
    twitter_user = build_twitter_user

    assert User.first_or_import_from_twitter_noise_user(twitter_user)
  end

  test "no new user when importing an old user" do
    twitter_user = build_twitter_user

    User.first_or_import_from_twitter_noise_user(twitter_user)

    assert_no_difference('User.count') do 
      assert User.first_or_import_from_twitter_noise_user(twitter_user)
    end
  end
end
