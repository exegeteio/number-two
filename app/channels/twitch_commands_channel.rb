class TwitchCommandsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "twitch_commands"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ChatCommandJob.perform_later(data)
  end
end
