# frozen_string_literal: true

# Class for handling inbound info from twitch.
class TwitchReflex < ApplicationReflex
  BANNED_USERS = %w[pretzelrocks nightbot b3_bot].freeze

  def chat(id, channel, message, message_emotes, username, user_color)
    return unless broadcast_to? channel
    return if BANNED_USERS.include? username.downcase

    ChatBroadcasterJob.perform_later(
      channel,
      render(
        ChatMessageComponent.new(
          id: id,
          message: TwitchMessage.process_emotes(message, message_emotes),
          user: username,
          avatar_url: TwitchMessage.avatar_for(username),
          user_color: user_color
        )
      )
    )
  end

  def command(id, channel, command, message, username, user_color)
    handlers[command].call(
      command: command,
      user: current_user,
      id: id,
      channel: channel,
      message: message,
      username: username,
      user_color: user_color
    )
  end

  private

  def broadcast_to?(channel)
    if current_user.admin? || current_user.username == channel
      true
    else
      Rails.logger.warn(
        "[#{self.class}] Unable to verify channel #{channel} for user #{connection.current_user.username}"
      )
      false
    end
  end

  def default_handler
    ->(command:, user:, id:, channel:, message:, username:, user_color:) do
      Rails.logger.error("Unable to find matching command: #{command}")
    end
  end

  def handlers
    @handlers ||= HashWithIndifferentAccess.new
    @handlers.default = default_handler
    @handlers[:ask] = ->(command:, user:, id:, channel:, message:, username:, user_color:) do
      Ask.create_or_find_by!(message_id: id) do |t|
        t.user_name = username
        t.user_color = user_color
        t.message = message
        t.channel = channel
      end
    end
    @handlers[:todo] = ->(command:, user:, id:, channel:, message:, username:, user_color:) do
      return unless username == user.username

      Todo.create_or_find_by!(message_id: id) do |t|
        t.username = username
        t.message = message
        t.channel = channel
      end
    end
    @handlers
  end
end
