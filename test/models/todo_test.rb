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
require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
