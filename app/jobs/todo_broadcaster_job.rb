class TodoBroadcasterJob < ApplicationJob
  include CableReady::Broadcaster
  queue_as :default

  def perform(todo)
    cable_ready["todo_messages_#{todo.channel}"].morph(
      selector: '#todo_list',
      children_only: true,
      html: renderer.render(TodoComponent.with_collection(Todo.pending.where(channel: todo.channel)))
    )
    cable_ready["current_todo_#{todo.channel}"].inner_html(
      selector: '#todo_overlay',
      html: if Todo.active.present?
              renderer.render(TodoMessageComponent.new(todo: Todo.active.first))
            end
    )
    cable_ready.broadcast
  end
end
