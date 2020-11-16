# frozen_string_literal: true

module TwitchTokenHelper
  def twitch_token
    session.dig('devise.twitch_data', 'credentials', 'token')
  end

  def twitch_userid
    session.dig('devise.twitch_data', 'extra', 'raw_info', 'id')
  end
end
