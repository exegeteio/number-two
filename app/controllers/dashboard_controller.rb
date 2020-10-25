class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @todos = Todo.pending
  end
end
