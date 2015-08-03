module TwitterTranslators
  class UserTranslator
    attr_reader :users

    def self.translate(twitter_user_or_twitter_users)
      new.translate twitter_user_or_twitter_users
    end

    def initialize
      reset_users
    end

    def translate(twitter_user_or_twitter_users)
      reset_users

      twitter_users =
        if twitter_user_or_twitter_users.respond_to?(:each)
          twitter_user_or_twitter_users
        else
          [twitter_user_or_twitter_users]
        end

      twitter_users.each do |twitter_user|
        user = find_or_create_user_from_twitter_user(twitter_user)
        users << user
      end

      users
    end

    private

    def reset_users
      @users = []
    end

    def find_or_create_user_from_twitter_user(twitter_user)
      User.find_by(
        provider: User::PROVIDER_TWITTER,
        provider_id: twitter_user.id.to_s
      ) || create_user_from_twitter_user(twitter_user)
    end

    def create_user_from_twitter_user(twitter_user, following: true)
      Rails.logger.info "Creating a user from tweet: [#{twitter_user.inspect}]"

      user = User.create!(
        name: twitter_user.name,
        provider: User::PROVIDER_TWITTER,
        provider_id: twitter_user.id.to_s,
        provider_screen_name: twitter_user.screen_name,
        following: following,
      )
      user.create_original!(dump: twitter_user.to_json)
      user
    end
  end
end
