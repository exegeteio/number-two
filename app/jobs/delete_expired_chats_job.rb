# Job for deleting expired Messages.
class DeleteExpiredChatsJob < ApplicationJob
  queue_as :default

  def perform
    Message.expired.destroy_all
  end
end
