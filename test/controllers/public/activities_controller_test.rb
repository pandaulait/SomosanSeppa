require 'test_helper'

class Public::ActivitiesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get public_activities_index_url
    assert_response :success
  end
end
