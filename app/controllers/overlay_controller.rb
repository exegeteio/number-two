# frozen_string_literal: true

class OverlayController < ApplicationController
  layout 'overlay'
  def index
    @channel = params[:channel]
    @todo = Todo.active.where(channel: @channel).first
    @ask = Ask.active.where(channel: @channel).first
  end

  def subpoints
    @channel = params[:channel]
  end
end
