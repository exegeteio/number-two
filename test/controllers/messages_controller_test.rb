require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test 'should swap active status on PATCH' do
    patch message_url(messages(:ask)), params: { message: { status: :active } }
    assert_response :success
    assert messages(:ask).reload.active?
  end

  test 'should change kind on PATCH' do
    patch message_url(messages(:ask)), params: { message: { kind: :todo } }
    assert_response :success
    assert_includes Message.todo.pluck(:id), messages(:ask).id
  end

  test 'should remove Message on DELETE' do
    assert_difference 'Message.count', -1 do
      delete message_url(messages(:todo))
      assert_response :success
    end
  end
end
