class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  private

  def render_component(renderable, options = {})
    renderer.render(renderable, options.reverse_merge({layout: false}))
  end

  def renderer
    ApplicationController
  end
end
