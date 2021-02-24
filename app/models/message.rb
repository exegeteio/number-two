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
  # Enabled broadcasts
  include Turbo::Broadcastable

  # Set an expiration age for chat messages.
  class_attribute :chat_timeout, default: 45.seconds
  enum status: %i[active inactive deleted]
  enum kind: %i[chat ask todo]

  # Default scope by :created_at since id us UUID.
  default_scope -> { order(created_at: :desc) }
  # Only include messages updated within the last 5 minutes.
  scope :recent, -> { where('updated_at > ?', chat_timeout.ago) }
  # Expired is only for chats older than 5 minutes ago.
  scope :expired, -> { chat.where('updated_at < ?', chat_timeout.ago) }
  # Narrow by channel
  scope :for_channel, ->(channel) { where(channel: channel) }

  validates_presence_of %i[channel content from_username]

  # Callback for broadcast messages via HOTwire.
  broadcasts_to :channel, inserts_by: :prepend
  # Destroy all expired messages.
  after_create :queue_deletion
  # Destroy all expired messages.
  after_update :ensure_unique_active_by_kind, if: :active?

  def self.default_status_for(kind)
    default_statuses[kind]
  end

  def self.default_statuses
    default_statuses = Hash.new(:inactive)
    default_statuses[:chat] = :active
    default_statuses
  end

  private

  def queue_deletion
    DeleteExpiredChatsJob.set(wait: chat_timeout).perform_later
  end

  def ensure_unique_active_by_kind
    Message.for_channel(channel).where(kind: kind).where.not(id: id).update(status: :inactive)
  end
end
