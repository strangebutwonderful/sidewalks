require 'test_helper'

class TwitterTranslatorTest < ActiveSupport::TestCase
  def build_twitter_user
    OpenStruct.new(
      id: 'my_twitter_user_id',
      name: 'my_twitter_user_name',
      email: 'my_twitter_user_email@example.org',
      screen_name: 'my_twitter_screen_name',
      profile_image_uri_https: Faker::Internet.url,
      created_at: 1.hour.ago
    )
  end

  def build_tweet
    twitter_user = build_twitter_user

    OpenStruct.new(
      id: 'my_twitter_noise_id',
      text: 'my_twitter_noise_text',
      full_text: 'my_twitter_noise_text',
      created_at: Time.now,
      user: twitter_user
    )
  end

  test 'creates a new noise when translating' do
    assert_difference -> { Noise.count } do
      TwitterTranslators::TweetTranslator.translate(build_tweet)
    end
  end

  test 'returns a list of noises when translating' do
    assert_equal(
      TwitterTranslators::TweetTranslator.translate(build_tweet).length,
      1
    )
  end

  test 'sets values of noises' do
    tweet = build_tweet

    TwitterTranslators::TweetTranslator.translate(tweet).first.tap do |t|
      assert_equal(tweet.id, t.provider_id)
      assert_equal(tweet.text, t.text)
      assert_equal(tweet.created_at, t.created_at)
      assert_equal(
        tweet.user.profile_image_uri_https.to_s,
        t.avatar_image_url
      )
    end
  end

  test 'no new noise when importing old tweet' do
    tweet = build_tweet

    TwitterTranslators::TweetTranslator.translate(tweet)

    assert_no_difference -> { Noise.count } do
      TwitterTranslators::TweetTranslator.translate(tweet)
    end
  end
end
