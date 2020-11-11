# frozen_string_literal: true

# Component for displaying a message in the dashboard.
class AskComponent < ViewComponent::Base
  attr_accessor :message, :user, :user_color, :channel

  def initialize(message:, user:, user_color:, channel:)
    super
    @message = message
    @user = user
    @user_color = user_color
    @channel = channel
  end
end
