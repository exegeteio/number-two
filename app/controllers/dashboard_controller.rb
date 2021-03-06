# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @todos = Todo.pending.where(channel: current_user.username.downcase)
    @asks = Ask.pending.where(channel: current_user.username.downcase)
  end
end
