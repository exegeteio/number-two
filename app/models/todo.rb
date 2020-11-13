# Model for Todo records.
class Todo < ApplicationRecord
  enum status: %i[pending active completed deleted]

  scope :pending, -> { where(status: %i[pending active]) }
end
