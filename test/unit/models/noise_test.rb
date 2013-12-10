# == Schema Information
#
# Table name: noises
#
#  id               :integer          not null, primary key
#  provider_id      :string(255)      not null
#  user_id          :integer          not null
#  text             :text             not null
#  longitude        :decimal(11, 8)
#  latitude         :decimal(11, 8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  provider         :string(255)      not null
#  avatar_image_url :string(255)
#
# Indexes
#
#  index_noises_on_latitude_and_longitude  (latitude,longitude)
#  index_noises_on_user_id                 (user_id)
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

  test "imports raw twitter object" do
    twitter_noise = build_twitter_noise

    user = User.first_or_import_from_twitter_noise_user(twitter_noise.user)

    noise = Noise.new

    assert noise.import_from_twitter_noise(twitter_noise, user)
  end

  test "imports noise when new noise" do
    twitter_noise = build_twitter_noise

    user = User.first_or_import_from_twitter_noise_user(twitter_noise.user)

    assert Noise.first_or_import_from_twitter_noise(twitter_noise, user)
  end

  test "no new noise when importing old tweet" do 
    twitter_noise = build_twitter_noise

    user = User.first_or_import_from_twitter_noise_user(twitter_noise.user)

    Noise.first_or_import_from_twitter_noise(twitter_noise, user)

    assert_no_difference('Noise.count') do 
      assert Noise.first_or_import_from_twitter_noise(twitter_noise, user)
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

  test "located scope includes noise with coordinates" do
    assert_difference('Noise.where_has_coordinates.count') do
      FactoryGirl.create(:noise_with_coordinates)
    end
  end

  test "located scope does not include noise without coordinates" do
    assert_no_difference('Noise.where_has_coordinates.count') do
      FactoryGirl.create(:noise)
    end
  end
end
