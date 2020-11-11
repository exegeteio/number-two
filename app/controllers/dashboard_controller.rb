class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @todos = Todo.pending.where(channel: current_user.username)
    request.variant = :paper
  end
end
