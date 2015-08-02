class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...

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
end
