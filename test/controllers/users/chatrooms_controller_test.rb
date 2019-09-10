require 'test_helper'

class Users::ChatroomsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_chatrooms_show_url
    assert_response :success
  end

  test "should get create" do
    get users_chatrooms_create_url
    assert_response :success
  end

end
