# frozen_string_literal: true

# Class for handling inbound info from twitch.
class TwitchReflex < ApplicationReflex
  def chat(id, channel, message, message_emotes, username, user_color)
    return unless broadcast_to? channel

    ChatMessageJob.perform_later(id, channel, sanitize(message), message_emotes, username, user_color)
  end

  def command(id, channel, command, message, username, user_color)
    ChatCommandJob.perform_later(connection.current_user, id, channel, command, message, username, user_color)
  end

  private

  def broadcast_to?(channel)
    if current_user.username == channel
      true
    else
      Rails.logger.warn(
        "[#{self.class}] Unable to verify channel #{channel} for user #{connection.current_user.username}"
      )
      false
    end
  end

  def sanitize(str)
    @sanitizer ||= Rails::Html::FullSanitizer.new
    @sanitizer.sanitize(str)
  end
end
