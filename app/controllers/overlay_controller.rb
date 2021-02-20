# frozen_string_literal: true

# Show the overlays for a given channel with:
# - Chat messages
# - Active Ask
# - Active Todo
class OverlayController < ApplicationController
  before_action :set_channel
  def show
    # TODO: Pull chats, current Ask, and current Todo.
  end

  private

  def set_channel
    @channel = params.require(:channel).downcase
  end
end
