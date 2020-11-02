class OverlayController < ApplicationController
  layout 'overlay'
  def index
    @channel = params[:channel]
    @todo = Todo.active.where(channel: @channel).first
  end
end
