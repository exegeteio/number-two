# frozen_string_literal: true

# Component for rendering todos.
class TodoComponent < ViewComponent::Base
  attr_accessor :todo

  delegate :active?, to: :todo

  def initialize(todo:)
    super
    @todo = todo
  end
end
