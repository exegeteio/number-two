require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:non_default)
    sign_in @user
    get dashboard_url
    @messages = Message.for_channel(@user.username)
  end

  test 'should redirect if not authenticated' do
    sign_out @user
    get dashboard_url(channel: 'default')
    assert_response :redirect
  end

  test 'should get index' do
    assert_response :success
  end

  test 'should include all messages' do
    assert_response :success
    assert_select '#messages' do
      assert_select '.message', @messages.count
    end
  end
end
