class ChatMessageJob < ApplicationJob
  queue_as :default

  BANNED_USERS = %w[pretzelrocks nightbot b3_bot].freeze

  def perform(args)
    args['avatar'] = avatar_for args['user']
    ActionCable.server.broadcast(
      'chat_overlay_messages',
      render(args)
    ) unless BANNED_USERS.include? args['user'].downcase
  end

  private

  def avatar_for(username)
    Rails.cache.fetch("avatar/#{username}", expires_in: 12.hours) do
      $TWITCH.get_users(login: username).data[0].profile_image_url
    end
  end

  def render(args)
    ApplicationController.new.render_to_string(
      partial: 'messages/chat',
      locals: get_locals(args)
    )
  end

  def get_locals(args)
    {
      id: args['id'],
      avatar: args['avatar'],
      highlighted: args['highlighted'],
      message: args['message'],
      user_color: args['userColor'],
      user: args['user']
    }
  end
end
