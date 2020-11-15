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
require 'test_helper'

class AskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
