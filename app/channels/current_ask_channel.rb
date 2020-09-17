class CurrentAskChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'current_ask_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast(
      'current_ask_channel',
      data
    )
  end
end
