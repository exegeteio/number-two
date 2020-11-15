# frozen_string_literal: true

class TodoController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo

  def promote
    Todo.active.where(channel: current_user.username).update(status: :pending)
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
    @todo = Todo.find_by!(id: params[:id], channel: current_user.username)
  end
end
