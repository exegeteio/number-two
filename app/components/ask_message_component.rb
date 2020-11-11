# frozen_string_literal: true

# Class for rendering an ask message for the screen.
class AskMessageComponent < ViewComponent::Base
  attr_accessor :user, :user_color, :message

  def initialize(user:, user_color:, message:)
    super
    @user = user
    @user_color = user_color
    @message = message
  end
end
