class TodoController < ApplicationController
  before_action :set_todo

  def promote
    Todo.active.update(status: :pending)
    @todo.active!
  end

  def complete
    @todo.completed!
  end

  def delete
    @todo.deleted!
  end

  private

  def set_todo
    @todo = Todo.find_by! id: params[:id]
  end
end
