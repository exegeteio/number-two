# frozen_string_literal: true

# Message controller for updating Messages.
class MessagesController < ApplicationController
  before_action :set_message

  def update
    if @message.update(message_params)
      render plain: 'OK', status: :ok
    else
      render plain: 'NOT OK', status: :internal_server_error
    end
  end

  def destroy
    @message.destroy
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:status, :kind)
  end
end
