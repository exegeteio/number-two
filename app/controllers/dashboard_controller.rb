# frozen_string_literal: true

# Controller for displaying presenter dashboard and related
# components.
class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel

  def index
    request.variant = :dashboard
    @messages = Message.for_channel(@channel)
  end

  private

  def set_channel
    @channel = current_user.username.downcase
  end
end
