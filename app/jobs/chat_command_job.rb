class ChatCommandJob < ApplicationJob
  queue_as :default

  def perform(args)
    case args['command']
    when 'ask'
      ActionCable.server.broadcast(
        'ask_messages',
        render(args)
      )
    end
  end

  private

  def render(args)
    ApplicationController.new.render_to_string(
      partial: 'messages/ask',
      locals: get_locals(args)
    )
  end

  def get_locals(args)
    {
      question: args['message'],
      user_color: args['userColor'],
      user: args['user']
    }
  end
end
