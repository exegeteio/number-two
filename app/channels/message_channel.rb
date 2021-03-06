# frozen_string_literal: true

# Receive messages from JavaScript in the browser.
class MessageChannel < ApplicationCable::Channel
  def receive(data)
    Message.create!(
      channel: current_user.username.downcase,
      from_username: data['from_username'],
      content: data['content'],
      kind: data['kind']&.to_sym,
      status: Message.default_status_for(data['kind'].to_sym)
    )
  end
end
