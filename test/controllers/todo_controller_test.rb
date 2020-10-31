require 'test_helper'

class TodoControllerTest < ActionDispatch::IntegrationTest
  test 'should get promote' do
    get todo_promote_url
    assert_response :success
  end

  test 'should get complete' do
    get todo_complete_url
    assert_response :success
  end

  test 'should get delete' do
    get todo_delete_url
    assert_response :success
  end
end
