# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id            :uuid             not null, primary key
#  channel       :string
#  content       :string
#  from_username :string
#  kind          :integer          default("chat"), not null
#  status        :integer          default("active"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Message < ApplicationRecord
  enum status: %i[active inactive deleted]
  enum kind: %i[chat ask todo]

  # Broadcast messages via HOTwire.
  include Turbo::Broadcastable
  broadcasts_to :channel

  # TODO:  Add validation!
  validates_presence_of %i[channel content from_username]

  # Only include messages updated within the last 5 minutes.
  scope :recent, -> { where('updated_at > ?', 5.minutes.ago) }

  # Narrow by channel
  scope :for_channel, ->(channel) { where(channel: channel) }
end
