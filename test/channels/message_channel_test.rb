require 'test_helper'

class MessageChannelTest < ActionCable::Channel::TestCase
  test 'subscribes' do
    subscribe
    assert subscription.confirmed?
  end

  test 'creates messages' do
    subscribe
    channel = MessageChannel.new(connection, {})
    assert_difference 'Message.count' do
      channel.perform_action(Message.first.attributes.except('id'))
    end
  end
end
