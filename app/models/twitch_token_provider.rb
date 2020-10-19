# frozen_string_literal: true

# Wrapper for Twitch API.
class TwitchTokenProvider
  def initialize(client_id:, client_secret:)
    @client_id = client_id
    @client_secret = client_secret
  end

  def oauth_token
    twitch_api.oauth_token
  end

  private

  def twitch_api
    @twitch_api ||= TwitchOauthApi.new(
      client_id: @client_id,
      client_secret: @client_secret
    )
  end
end
