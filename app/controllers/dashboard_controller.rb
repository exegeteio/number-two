class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @todos = Todo.pending.where(channel: current_user.username)
    @asks = Ask.pending.where(channel: current_user.username)
  end
end
