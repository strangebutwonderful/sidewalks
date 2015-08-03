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

  test "creates user when new user" do
    twitter_user = build_twitter_user

    assert_difference -> { User.count } do
      TwitterTranslators::UserTranslator.translate(twitter_user)
    end
  end

  test "no new user when creating an old user" do
    twitter_user = build_twitter_user

    TwitterTranslators::UserTranslator.translate(twitter_user)

    assert_no_difference -> { User.count } do
      TwitterTranslators::UserTranslator.translate(twitter_user)
    end
  end
end
