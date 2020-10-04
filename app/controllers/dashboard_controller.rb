class DashboardController < ApplicationController
  def index
    @todos = Todo.pending
  end
end
