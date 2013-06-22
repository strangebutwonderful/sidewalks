Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_PROVIDER_KEY'], ENV['TWITTER_PROVIDER_SECRET']
end
