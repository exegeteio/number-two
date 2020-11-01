# Todo command for displaying !todo in the presenter dashboard.
class TwitchCommands
  class Todo < TwitchCommands::Base
    def self.call(user:, locals:)
      ::Todo.create_or_find_by!(message_id: locals[:id]) do |t|
        t.username = locals[:username]
        t.message = locals[:message]
        t.channel = locals[:channel]
      end if locals[:username] == user.username
    end
  end
end
