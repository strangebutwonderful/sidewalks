require "test_helper"

class TwitterTranslatorTest < ActiveSupport::TestCase
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

  def build_tweet
    twitter_user = build_twitter_user

    OpenStruct.new(
      id: "my_twitter_noise_id",
      text: "my_twitter_noise_text",
      full_text: "my_twitter_noise_text",
      created_at: Time.now,
      user: twitter_user
    )
  end

  test "imports raw twitter object" do
    assert_difference -> { Noise.count } do
      TwitterTranslator.translate(build_tweet)
    end
  end

  test "imports noise when new noise" do
    assert_difference -> { Noise.count } do
      TwitterTranslator.translate(build_tweet)
    end
  end

  test "no new noise when importing old tweet" do
    tweet = build_tweet

    TwitterTranslator.translate(tweet)

    assert_no_difference -> { Noise.count } do
      TwitterTranslator.translate(tweet)
    end
  end
end
