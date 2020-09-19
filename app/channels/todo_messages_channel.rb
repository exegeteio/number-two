class TodoMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'todo_messages'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
