# frozen_string_literal: true

# HTTP access for Twitch API using Faraday.
class TwitchOauthApi < Faraday::Connection
  def initialize(client_id:, client_secret:)
    @client_id = client_id
    @client_secret = client_secret
    super(
      url: 'https://id.twitch.tv/oauth2'
    ) do |faraday|
      faraday.response :json
      faraday.adapter Faraday.default_adapter
      # faraday.response :logger, nil, { headers: true, bodies: true }
    end
  end

  def oauth_token
    post("token?#{oauth_params}").body['access_token']
  end

  private

  def oauth_params
    {
      client_id: @client_id,
      client_secret: @client_secret,
      grant_type: 'client_credentials',
      scope: 'channel:moderate chat:edit chat:read'
    }.to_query
  end
end
