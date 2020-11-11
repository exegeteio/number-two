# frozen_string_literal: true

# Component for displaying a chat message in an overlay.
class ChatMessageComponent < ViewComponent::Base
  attr_accessor :id, :message, :user, :user_color, :avatar_url

  def initialize(id:, message:, user:, user_color:, avatar_url:)
    super
    @id = id
    @message = message
    @user = user
    @user_color = user_color
    @avatar_url = avatar_url
  end
end
