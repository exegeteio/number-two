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

  test 'for_channel limits results to a specific channel' do
    # TODO:  Is there a way to do away with the "magic" number, 1?
    assert_equal Message.for_channel('twitch').count, 1
  end
end
