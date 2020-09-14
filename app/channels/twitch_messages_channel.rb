class TwitchMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "twitch_messages"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ChatMessageJob.perform_later(data)
  end
end
