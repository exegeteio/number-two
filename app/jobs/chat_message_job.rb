class ChatMessageJob < ApplicationJob
  queue_as :default

  def perform(args)
    ActionCable.server.broadcast(
      "chat_overlay_messages",
      render(args)
    )
  end

  private

  def render(args)
    ApplicationController.new.render_to_string(
      partial: 'messages/chat',
      locals: {
        id: args["id"],
        user: args["user"],
        message: args["message"],
        highlighted: args["highlighted"],
        user_color: args["userColor"],
      }
    )
  end
end
