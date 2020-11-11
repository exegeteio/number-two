# Component for rendering a single todo message.
class TodoMessageComponent < ViewComponent::Base
  attr_accessor :todo

  def initialize(todo:)
    super
    @todo = todo
  end
end
