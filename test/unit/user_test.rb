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
    importable_userlike_object = OpenStruct.new(
      FactoryGirl.attributes_for(:user)
    )

    user = User.new

    assert user.import_from_twitter_noise_user(importable_userlike_object)
  end

  test "imports user when new user" do
    importable_userlike_object = OpenStruct.new(
      FactoryGirl.attributes_for(:user)
    )

    user = FactoryGirl.create(:user)

    assert User.first_or_import_from_twitter_noise(importable_userlike_object)
  end

  test "imports user when old user" do
    user = FactoryGirl.create(:user)

    importable_userlike_object = OpenStruct.new(
      user.attributes
    )

    user = FactoryGirl.create(:user)

    assert User.first_or_import_from_twitter_noise(importable_userlike_object)
  end  
end
