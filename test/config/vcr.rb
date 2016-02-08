VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = false
  config.cassette_library_dir = 'test/vcr_cassettes'
  config.default_cassette_options = {
    match_requests_on: [:method, :query, :uri]
  }
  config.hook_into :webmock # or :fakeweb
end
