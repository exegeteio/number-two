# Model for holding asked questions.
class Ask < ApplicationRecord
  enum status: %i[pending active completed deleted]

  default_scope -> { order(created_at: :asc) }
  scope :pending, -> { where(status: %i[pending active]) }
  scope :active, -> { where(status: :active) }
end
