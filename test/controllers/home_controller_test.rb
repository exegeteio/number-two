require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get home_root_url
    assert_response :success
  end

end
