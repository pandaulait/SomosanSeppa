require 'test_helper'

class Admin::QuizzesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get admin_quizzes_index_url
    assert_response :success
  end

  test 'should get show' do
    get admin_quizzes_show_url
    assert_response :success
  end
end
