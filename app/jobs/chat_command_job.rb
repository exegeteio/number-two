# Job for translating a chat command to a TwitchCommand call
# TwitchCommand call can then broadcast via ActionCAble
# whatever response is needed.
class ChatCommandJob < ApplicationJob
  queue_as :default

  def perform(user, id, channel, command, message, username, user_color)
    handlers[command].call(
      command: command,
      user: user,
      id: id,
      channel: channel,
      message: message,
      username: username,
      user_color: user_color
    )
  end

  private

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
