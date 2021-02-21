# frozen_string_literal: true

# Controller for displaying presenter dashboard and related
# components.
class DashboardController < ApplicationController
  before_action :set_channel

  def index
    request.variant = :dashboard
    @messages = Message.for_channel(@channel)
  end

  private

  def set_channel
    # TODO:  Make this pull from current_user.username after devise is working!
    @channel = params.require(:channel)
  end
end
