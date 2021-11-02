require 'test_helper'

class Public::TodayQuizzesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_today_quizzes_index_url
    assert_response :success
  end

end
