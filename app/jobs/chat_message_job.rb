class ChatMessageJob < ApplicationJob
  queue_as :default

  def perform(args)
    args['avatar'] = avatar_for args['user']
    ActionCable.server.broadcast(
      "chat_overlay_messages",
      render(args)
    )
  end

  private

  def avatar_for(username)
    return "/no-avitar.png?u=#{username}"
  end

  def render(args)
    ApplicationController.new.render_to_string(
      partial: 'messages/chat',
      locals: {
        id: args['id'],
        avatar: args['avatar'],
        highlighted: args['highlighted'],
        message: args['message'],
        user_color: args['userColor'],
        user: args['user'],
      }
    )
  end
end
