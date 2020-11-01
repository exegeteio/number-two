# Ask command for displaying !ask in the presenter dashboard.
class TwitchCommands
  class Ask < TwitchCommands::Base
    def self.call(locals:)
      broadcast(
        "ask_messages_#{locals[:channel]}",
        render(locals)
      )
    end
  end
end
