# frozen_string_literal: true

# Show the overlays for a given channel with:
# - Chat messages
# - Active Ask
# - Active Todo
class OverlayController < ApplicationController
  layout 'overlay'
  before_action :set_channel
  before_action :set_user

  def show
    @messages = Message.for_channel(@channel)
  end

  private

  def set_channel
    @channel = params.require(:channel).downcase
  end

  def set_user
    @user = User.find_by!(username: @channel)
  end
end
