# frozen_string_literal: true

class ChatOverlayMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_overlay_messages_#{params['twitch_channel'].downcase}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
