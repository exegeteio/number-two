# frozen_string_literal: true

class CurrentAskChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current_ask_#{params['twitch_channel'].downcase}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
