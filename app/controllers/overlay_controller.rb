class OverlayController < ApplicationController
  def index
    @todo = Todo.active.first
  end
end
