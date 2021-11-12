require 'test_helper'

class Admin::ChatRoomsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get admin_chat_rooms_index_url
    assert_response :success
  end
end
