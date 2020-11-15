# frozen_string_literal: true

class CurrentTodoChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current_todo_#{params['twitch_channel']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
