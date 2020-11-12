class Ask < ApplicationRecord
  after_save :alert
  enum status: %i[pending active completed deleted]

  scope :pending, -> { where(status: %i[pending active]) }

  private

  def alert
    AskBroadcasterJob.perform_later(self)
  end
end
