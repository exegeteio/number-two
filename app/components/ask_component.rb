# frozen_string_literal: true

# Component for displaying a message in the dashboard.
class AskComponent < ViewComponent::Base
  attr_accessor :ask

  delegate :active?, to: :ask

  def initialize(ask:)
    super
    @ask = ask
  end
end
