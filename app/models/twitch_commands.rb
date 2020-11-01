# Base class for all twitch commands.
class TwitchCommands
  def self.call(command:, locals:, user:)
    "TwitchCommands::#{command.titleize}".constantize.call(user: user, locals: locals)
  rescue NameError
    Rails.logger.error("Unable to find matching command: #{command}")
  end

  class Base
    def self.broadcast(channel, content)
      ActionCable.server.broadcast(channel, content)
    end

    def self.render(locals)
      ApplicationController.new.render_to_string(
        partial: to_s.underscore,
        locals: locals
      )
    end

    def self.mod?(locals)
      locals[:broadcaster] || locals[:mod]
    end
  end
end

require_relative 'twitch_commands/ask'
require_relative 'twitch_commands/todo'
