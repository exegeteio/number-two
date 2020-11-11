class TodoBroadcasterJob < ApplicationJob
  queue_as :default

  def perform(todo)
    ActionCable.server.broadcast(
      "todo_messages_#{todo.channel}",
      {
        id: todo.id,
        status: todo.status,
        html: ApplicationController.render(
          TodoComponent.new(todo: todo)
        ),
        message_html: ApplicationController.render(
          TodoMessageComponent.new(todo: todo)
        )
      }
    )
  end
end
