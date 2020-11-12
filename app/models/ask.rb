class Ask < ApplicationRecord
  after_save :alert
  enum status: %i[pending active completed deleted]

  default_scope -> { order(created_at: :asc) }
  scope :pending, -> { where(status: %i[pending active]) }
  scope :active, -> { where(status: :active) }

  private

  def alert
    AskBroadcasterJob.perform_later(self)
  end
end
