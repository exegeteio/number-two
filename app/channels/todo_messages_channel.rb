class TodoMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "todo_messages_#{connection.current_user.username}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
