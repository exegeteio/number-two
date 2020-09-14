class ChatOverlayMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_overlay_messages"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
