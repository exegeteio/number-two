class CurrentAskChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current_ask_#{params['twitch_channel']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast(
      "current_ask_#{connection.current_user.username}",
      data
    )
  end
end
