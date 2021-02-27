require 'test_helper'

class MessageChannelTest < ActionCable::Channel::TestCase
  setup do
    @user = users(:default)
    stub_connection current_user: @user
    subscribe
  end

  test 'subscribes' do
    assert subscription.confirmed?
  end

  test 'creates messages' do
    channel = MessageChannel.new(connection, {})
    assert_difference 'Message.count' do
      channel.perform_action(Message.first.attributes.except('id'))
    end
  end

  test 'creates messages for current_user' do
    channel = MessageChannel.new(connection, {})
    channel.perform_action(Message.first.attributes.except('id'))
    assert_equal Message.last.channel, @user.username
  end
end
