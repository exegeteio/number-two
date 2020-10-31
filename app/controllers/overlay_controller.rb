class OverlayController < ApplicationController
  def index
    @todo = Todo.active.first
    @channel = params[:channel]
  end
end
