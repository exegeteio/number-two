# frozen_string_literal: true

class TwitchCommands
  # Ask command for displaying !ask in the presenter dashboard.
  class Ask < TwitchCommands::Base
    include CableReady::Broadcaster

    def self.call(user:, locals:)
      cable_ready["ask_messages_#{locals[:channel]}"].insert_adjacent_html(
        selector: '#ask_list',
        html: render(locals)
      )
      # broadcast(
      #   "ask_messages_#{locals[:channel]}",
      #   render(locals)
      # )
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
