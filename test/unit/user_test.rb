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
#

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
