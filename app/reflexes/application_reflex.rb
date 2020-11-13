# frozen_string_literal: true

# Base class for all reflexes in this app.
class ApplicationReflex < StimulusReflex::Reflex
  delegate :render, to: ApplicationController
  delegate :current_user, to: :connection
end
