require 'test_helper'

class OverlayControllerTest < ActionDispatch::IntegrationTest
  setup do
    get overlay_url(channel: 'Exegete46')
  end

  test 'should get show' do
    assert_response :success
  end

  test 'should include active chats' do
    assert_response :success
    assert_select '#chats_overlay'
    skip('TODO:  Once messages are implemented, check for their presence.')
    assert_select '.chat', messages(:chat)
  end

  test 'should include active ask' do
    assert_response :success
    assert_select '#ask_overlay'
    skip('TODO:  Once messages are implemented, check for their presence.')
    assert_select '#ask_overlay', messages(:ask_active)
  end

  test 'should include active todo' do
    assert_response :success
    assert_select '#todo_overlay'
    skip('TODO:  Once messages are implemented, check for their presence.')
    assert_select '#todo_overlay', messages(:todo_active)
  end
end
