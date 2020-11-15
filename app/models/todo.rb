# frozen_string_literal: true

# == Schema Information
#
# Table name: todos
#
#  id         :bigint           not null, primary key
#  channel    :string
#  message    :string
#  status     :integer          default("pending")
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :uuid             not null
#
# Indexes
#
#  index_todos_on_message_id  (message_id) UNIQUE
#
# Model for Todo records.
class Todo < ApplicationRecord
  enum status: %i[pending active completed deleted]

  scope :pending, -> { where(status: %i[pending active]) }
end
