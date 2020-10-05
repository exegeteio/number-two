# Todo command for displaying !todo in the presenter dashboard.
class TwitchCommands
  class Todo < TwitchCommands::Base
    def self.call(locals:)
      ::Todo.create_or_find_by!(message_id: locals[:id]) do |t|
        t.username = locals[:username]
        t.message = locals[:message]
      end
    end
  end
end