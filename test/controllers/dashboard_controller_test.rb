require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    get dashboard_url(channel: 'default')
  end

  test 'should get index' do
    assert_response :success
  end

  test 'should include all messages' do
    assert_response :success
    assert_select '#messages' do
      assert_select '.message', Message.for_channel('default').count
    end
  end
end
