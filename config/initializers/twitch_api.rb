$TWITCH = Twitch::Client.new(
  client_id: ENV['TWITCH_CLIENT_ID'],
  access_token: ENV['TWITCH_ACCESS_TOKEN'],
)