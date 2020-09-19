class CurrentTodoChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'current_todo'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast(
      'current_todo',
      data
    )
  end
end
