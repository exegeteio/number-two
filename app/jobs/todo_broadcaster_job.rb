class TodoBroadcasterJob < ApplicationJob
  queue_as :default

  def perform(todo)
    ActionCable.server.broadcast(
      "todo_messages_#{todo.channel}",
      {
        id: todo.id,
        status: todo.status,
        html: ApplicationController.render(
          partial: 'todos/todo',
          layout: false,
          locals: { todo: todo }
        ),
        message_html: ApplicationController.render(
          partial: 'todos/todo_message',
          layout: false,
          locals: { todo: todo }
        )
      }
    )
  end
end
