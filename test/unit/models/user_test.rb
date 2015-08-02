# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string(255)      not null
#  email                        :string(255)
#  provider                     :string(255)      not null
#  provider_id                  :string(255)      not null
#  provider_screen_name         :string(255)
#  provider_access_token        :string(255)
#  provider_access_token_secret :string(255)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  following                    :boolean          default(FALSE), not null
#  locations_count              :integer          default(0), not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def build_twitter_user
    OpenStruct.new(
      id: "my_twitter_user_id",
      name: "my_twitter_user_name",
      email: "my_twitter_user_email@example.org",
      screen_name: "my_twitter_screen_name",
      profile_image_uri_https: Faker::Internet.url,
      created_at: 1.hour.ago
    )
  end

  test "FactoryGirl works" do
    assert_difference('User.count') do
      FactoryGirl.create(:user)
    end
  end

  test "FactoryGirl admin_user works" do
    assert_difference('User.count') do
      FactoryGirl.create(:admin_user)
    end
  end

  test "FactoryGirl user_with_original works" do
    assert_difference('User.count') do
      FactoryGirl.create(:user_with_original)
    end
  end

  test "creates raw twitter object" do
    twitter_user = build_twitter_user

    assert User.create_from_twitter!(twitter_user)
  end

  test "creates user when new user" do
    twitter_user = build_twitter_user

    assert User.first_or_create_from_twitter!(twitter_user)
  end

  test "no new user when creating an old user" do
    twitter_user = build_twitter_user

    User.first_or_create_from_twitter!(twitter_user)

    assert_no_difference('User.count') do
      assert User.first_or_create_from_twitter!(twitter_user)
    end
  end
end
