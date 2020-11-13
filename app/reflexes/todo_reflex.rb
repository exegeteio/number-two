# frozen_string_literal: true

class TodoReflex < ApplicationReflex
  before_reflex :set_todo
  after_reflex :update_todos

  def promote
    Todo.active.where(channel: current_user.username).update(status: :pending)
    @todo.active!
    cable_ready["current_todo_#{@todo.channel}"].inner_html(
      selector: '#todo_overlay',
      html: render(TodoMessageComponent.new(todo: @todo))
    )
    cable_ready.broadcast
  end

  def recall
    @todo.pending!
    clear_overlay
  end

  def complete
    @todo.completed!
    clear_overlay
  end

  def delete
    @todo.deleted!
  end

  private

  def clear_overlay
    cable_ready["current_todo_#{@todo.channel}"].inner_html(
      selector: '#todo_overlay',
      html: ''
    )
    cable_ready.broadcast
  end

  def update_todos
    morph '#todo_list', render(
      TodoComponent.with_collection(Todo.pending.where(channel: @todo.channel))
    )
  end

  def set_todo
    @todo = Todo.find_by!(
      id: element['data-id'],
      channel: current_user.username
    )
  end
end
