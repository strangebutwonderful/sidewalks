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
end
