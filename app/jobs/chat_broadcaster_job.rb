# frozen_string_literal: true

# Job for broadcasting chat messages.
class ChatBroadcasterJob < ApplicationJob
  include CableReady::Broadcaster
  queue_as :default

  def perform(channel, html)
    cable_ready["chat_overlay_messages_#{channel}"].insert_adjacent_html(
      selector: '#chat_message_list',
      html: html
    )
  end
end
