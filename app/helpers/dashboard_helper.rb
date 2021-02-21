# frozen_string_literal: true

# Helper methods for the Overlay controller and its components.
module DashboardHelper
  # Disabling Rubocop because there only needs to be one copy of this hash,
  # No need to take up extra memory by loading one per instance.
  # rubocop:disable Style/ClassVars
  # Notice that 'chat' is missing.  This is intentional as chats should be
  # hidden by default.
  @@message_title_classes = {
    'todo' => 'is-success',
    'ask' => 'is-warning'
  }
  # rubocop:enable Style/ClassVars

  # Determine the nes.css class for the title of a message when displayed
  # in the dashboard.
  def message_title_class(message)
    @@message_title_classes.fetch(message.kind, 'default')
  end
end
