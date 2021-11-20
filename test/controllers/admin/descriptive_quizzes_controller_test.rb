require 'test_helper'

class Admin::DescriptiveQuizzesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_descriptive_quizzes_show_url
    assert_response :success
  end

end
