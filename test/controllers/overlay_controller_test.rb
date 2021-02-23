require 'test_helper'

class OverlayControllerTest < ActionDispatch::IntegrationTest
  setup do
    @messages = Message.for_channel('default')
    get overlay_url(channel: 'default')
  end

  test 'should get show' do
    assert_response :success
  end

  test 'should include recent active chats for the channel' do
    assert_response :success
    assert_select '#messages' do
      assert_select '.chat', @messages.chat.count
    end
  end

  test 'should include active asks for the channel' do
    assert_response :success
    assert_select '#messages' do
      assert_select '.ask', @messages.ask.count
    end
  end

  test 'should include active todos for the channel' do
    assert_response :success
    assert_select '#messages' do
      assert_select '.ask', @messages.todo.count
    end
  end
end
