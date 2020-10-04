class Todo < ApplicationRecord
  scope :pending, -> { where(deleted: false, completed: false) }
end
