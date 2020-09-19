# Todo command for displaying !todo in the presenter dashboard.
class TwitchCommands
  class Todo < TwitchCommands::Base
    def self.call(locals:)
      broadcast('todo_messages', render(locals)) if mod?(locals)
    end
  end
end