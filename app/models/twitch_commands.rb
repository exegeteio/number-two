# Base class for all twitch commands.
class TwitchCommands
  def self.call(command:, locals:, user:)
    "TwitchCommands::#{command.titleize}".constantize.call(user: user, locals: locals)
  rescue NameError => e
    Rails.logger.error("Unable to find matching command: #{command} - #{e.message}")
  end

  class Base
    def self.broadcast(channel, content)
      ActionCable.server.broadcast(channel, content)
    end

    def self.render(_locals)
      raise NotImplementedError, "You must implement the #render method on #{self}"
    end

    def self.renderer
      ApplicationController.new
    end

    def self.mod?(locals)
      locals[:broadcaster] || locals[:mod]
    end
  end
end

require_relative 'twitch_commands/ask'
require_relative 'twitch_commands/todo'
