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
require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @chat = messages(:chat)
  end
  # TODO:  Look up how other people test simple models.
  # Do I need to test validation?
  test 'Sanity test' do
    assert @chat.chat?
  end

  test 'recent does not include messages 5 minutes old' do
    @chat.touch
    assert_includes Message.recent, @chat
    travel 5.minutes + 1.second
    assert_not_includes Message.recent, @chat
  end
end
