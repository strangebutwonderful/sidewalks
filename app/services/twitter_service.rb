class TwitterService

  attr_accessor :client, :consumer_key, :consumer_secret, :access_token, :access_token_secret

  def self.client(config: {})
    new(config).client
  end

  def initialize(config: {})
    @consumer_key = config[:consumer_key] || ENV['TWITTER_CONSUMER_KEY']
    @consumer_secret = config[:consumer_secret] || ENV['TWITTER_CONSUMER_SECRET']
    @access_token = config[:access_token] || ENV['TWITTER_OAUTH_ACCESS_TOKEN']
    @access_token_secret = config[:access_token_secret] || ENV['TWITTER_OAUTH_ACCESS_TOKEN_SECRET']
  end

  def client
    @@client ||= Twitter::REST::Client.new do |client_config|
      client_config.consumer_key = @consumer_key
      client_config.consumer_secret = @consumer_secret
      client_config.access_token = @access_token
      client_config.access_token_secret = @access_token_secret
    end
  end

end