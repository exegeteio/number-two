# frozen_string_literal: true

# == Schema Information
#
# Table name: asks
#
#  id         :bigint           not null, primary key
#  channel    :string
#  message    :string
#  status     :integer          default("pending")
#  user_color :string
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :uuid             not null
#
# Indexes
#
#  index_asks_on_channel     (channel)
#  index_asks_on_message_id  (message_id) UNIQUE
#
# Model for holding asked questions.
class Ask < ApplicationRecord
  enum status: %i[pending active completed deleted]

  default_scope -> { order(created_at: :asc) }
  scope :pending, -> { where(status: %i[pending active]) }
  scope :active, -> { where(status: :active) }
end
