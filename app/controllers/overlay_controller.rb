class OverlayController < ApplicationController
  def index
    @todo = Todo.pending.find_by(current: true)
  end
end
