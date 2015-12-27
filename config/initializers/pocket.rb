if Rails.env.development? || Rails.env.production?
  require 'pocket_api'
  PocketApi.configure(client_key: ENV["POCKET_CONSUMER_KEY"], access_token: nil)
end