# == Schema Information
#
# Table name: noises
#
#  id               :integer          not null, primary key
#  provider_id      :string(255)      not null
#  user_id          :integer          not null
#  text             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  provider         :string(255)      not null
#  avatar_image_url :string(255)
#
# Indexes
#
#  index_noises_on_user_id  (user_id)
#

require 'test_helper'

class NoiseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "FactoryGirl works" do
    assert_difference('Noise.count') do
      noise = FactoryGirl.create(:noise)
    end
  end

  test "FactoryGirl noise_with_original works" do
    assert_difference('Noise.count') do
      noise = FactoryGirl.create(:noise_with_original)
    end
  end

  test "FactoryGirl noise_with_coordinates works" do
    assert_difference('Noise.count') do
      noise = FactoryGirl.create(:noise_with_coordinates)
    end
  end

  test "FactoryGirl week_old_noise works" do
    assert_difference('Noise.count') do
      noise = FactoryGirl.create(:week_old_noise)
    end
  end

  test "imports raw twitter object" do
    tweet = build_tweet

    user = User.first_or_create_from_twitter!(tweet.user)

    assert Noise.create_from_tweet!(tweet, user)
  end

  test "imports noise when new noise" do
    tweet = build_tweet

    user = User.first_or_create_from_twitter!(tweet.user)

    assert Noise.first_or_create_from_tweet!(tweet, user)
  end

  test "no new noise when importing old tweet" do
    tweet = build_tweet

    user = User.first_or_create_from_twitter!(tweet.user)

    Noise.first_or_create_from_tweet!(tweet, user)

    assert_no_difference('Noise.count') do
      assert Noise.first_or_create_from_tweet!(tweet, user)
    end
  end

  test "latest scope includes recent tweets" do
    assert_difference('Noise.where_latest.count') do
      FactoryGirl.create(:noise)
    end
  end

  test "latest scope does not include old tweets" do
    assert_no_difference('Noise.where_latest.count') do
      FactoryGirl.create(:week_old_noise)
    end
  end

  test "noise with coordinates generates map" do
    noise = FactoryGirl.create(:noise_with_coordinates)
    assert_not_nil(noise.map)
  end

  test "media_urls never returns nil" do
    noise = FactoryGirl.create(:noise)
    assert_not_nil noise.media_urls
  end

  test "#explore" do
    civic_center_noise = FactoryGirl.create(:noise, :civic_center)
    marina_noise = FactoryGirl.create(:noise, :marina)

    civic_center_origin = civic_center_noise.origins.first

    found_noises = Noise.explore_nearest(
      latitude: civic_center_origin.latitude,
      longitude: civic_center_origin.longitude,
    )

    assert_includes( found_noises, civic_center_noise )
    refute_includes( found_noises, marina_noise )
  end
end
