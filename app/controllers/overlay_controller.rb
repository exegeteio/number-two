# frozen_string_literal: true

# Show the overlays for a given channel with:
# - Chat messages
# - Active Ask
# - Active Todo
class OverlayController < ApplicationController
  layout 'overlay'
  before_action :set_channel

  def show
    @messages = Message.for_channel(@channel)
  end

  private

  def set_channel
    @channel = params.require(:channel).downcase
  end
end
