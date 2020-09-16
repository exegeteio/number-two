# frozen_string_literal: true

require 'json'

# Class for holding twitch-API related functionality.
class TwitchTokenProvider
  def initialize(client_id:, client_secret:)
    @client_id = client_id
    @client_secret = client_secret
  end

  def access_token
    faraday.post("token?#{params.to_query}").body.dig('access_token')
  end

  private

  def faraday
    @faraday ||= Faraday.new(
      url: 'https://id.twitch.tv/oauth2'
    ) do |faraday|
      faraday.response :json
      faraday.adapter Faraday.default_adapter
      # faraday.response :logger, nil, { headers: true, bodies: true }
    end
  end

  def params
    {
      client_id: @client_id,
      client_secret: @client_secret,
      grant_type: 'client_credentials',
      scope: 'channel:moderate chat:edit chat:read'
    }
  end
end
