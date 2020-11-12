# frozen_string_literal: true

class TodoReflex < ApplicationReflex
  before_reflex :set_todo

  def promote
    Todo.active.where(channel: current_user.username).update(status: :pending)
    @todo.active!
  end

  def recall
    @todo.pending!
  end

  def complete
    @todo.completed!
  end

  def delete
    @todo.deleted!
  end

  private

  def set_todo
    @todo = Todo.find_by!(
      id: element['data-id'],
      channel: current_user.username
    )
  end
end
