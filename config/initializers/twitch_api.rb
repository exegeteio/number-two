# frozen_string_literal: true

if ENV['TWITCH_CLIENT_ID']
  twitch_token_provider = TwitchTokenProvider.new(
    client_id: ENV['TWITCH_CLIENT_ID'],
    client_secret: ENV['TWITCH_CLIENT_SECRET']
  )

  $TWITCH = Twitch::Client.new(
    access_token: twitch_token_provider.access_token,
    client_id: ENV['TWITCH_CLIENT_ID']
  )
end
