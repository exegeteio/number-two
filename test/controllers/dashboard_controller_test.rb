require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    get dashboard_url(channel: 'default')
  end

  test 'should get index' do
    assert_response :success
  end

  test 'should not include any chats' do
    assert_response :success
    assert_select '#messages' do
      assert_select '.chat:visible', 0
    end
  end
end
