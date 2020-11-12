# Job for translating a chat command to a TwitchCommand call
# TwitchCommand call can then broadcast via ActionCAble
# whatever response is needed.
class ChatCommandJob < ApplicationJob
  queue_as :default

  def perform(args, user)
    args.transform_keys! { |k| k.underscore.to_sym }
    handlers[args[:command]].call(
      command: args[:command],
      user: user,
      locals: args
    )
  end

  private

  def default_handler
    ->(command:, user:, locals:) do
      Rails.logger.error("Unable to find matching command: #{command}")
    end
  end

  def handlers
    @handlers ||= HashWithIndifferentAccess.new
    @handlers.default = default_handler
    @handlers[:ask] = ->(command:, user:, locals:) do
      Ask.create_or_find_by!(message_id: locals[:id]) do |t|
        t.user_name = locals[:username]
        t.user_color = locals[:user_color]
        t.message = locals[:message]
        t.channel = locals[:channel]
      end
    end
    @handlers[:todo] = ->(command:, user:, locals:) do
      return unless locals[:username] == user.username

      Todo.create_or_find_by!(message_id: locals[:id]) do |t|
        t.username = locals[:username]
        t.message = locals[:message]
        t.channel = locals[:channel]
      end
    end
    @handlers
  end
end
