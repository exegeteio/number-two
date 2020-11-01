class OverlayController < ApplicationController
  def index
    @channel = params[:channel]
    @todo = Todo.active.where(channel: @channel).first
  end
end
