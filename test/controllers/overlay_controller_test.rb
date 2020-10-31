require 'test_helper'

class OverlayControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get overlay_index_url
    assert_response :success
  end
end
