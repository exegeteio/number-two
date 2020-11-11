# frozen_string_literal: true

# Ask command for displaying !ask in the presenter dashboard.
class TwitchCommands
  class Ask < TwitchCommands::Base
    def self.call(user:, locals:)
      broadcast(
        "ask_messages_#{locals[:channel]}",
        render(locals)
      )
    end

    def self.render(locals)
      renderer.render_to_string AskComponent.new(
        user: locals[:user],
        user_color: locals[:user_color],
        message: locals[:message],
        channel: locals[:channel]
      )
    end
  end
end
