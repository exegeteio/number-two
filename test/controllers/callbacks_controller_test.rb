# frozen_string_literal: true

require 'test_helper'

class CallbacksControllerTest < ActionDispatch::IntegrationTest
  test 'should get twitch' do
    get callbacks_twitch_url
    assert_response :success
  end
end
