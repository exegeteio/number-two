class ChatCommandJob < ApplicationJob
  queue_as :default

  def perform(args)
    case args['command']
    when 'ask'
      ActionCable.server.broadcast(
        'ask_messages',
        render_ask(args)
      )
    when 'todo'
      ActionCable.server.broadcast(
        'todo_messages',
        render_todo(args)
      )
    end
  end

  private

  def render_ask(args)
    ApplicationController.new.render_to_string(
      partial: 'messages/ask',
      locals: get_locals(args)
    )
  end

  def render_todo(args)
    ApplicationController.new.render_to_string(
      partial: 'messages/todo',
      locals: {todo: args['message']}
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
