# frozen_string_literal: true

# Class for rendering an ask message for the screen.
class AskMessageComponent < ViewComponent::Base
  attr_accessor :ask

  def initialize(ask:)
    super
    @ask = ask
  end
end
