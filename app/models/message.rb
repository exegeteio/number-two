# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id            :bigint           not null, primary key
#  channel       :string
#  content       :string
#  from_username :string
#  kind          :integer
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Message < ApplicationRecord
  enum status: %i[active inactive deleted]
  enum kind: %i[chat ask todo]

  # Broadcast messages via HOTwire.
  include Turbo::Broadcastable
  broadcasts

  # TODO:  Add validation!
  validates_presence_of %i[channel content from_username]
end
