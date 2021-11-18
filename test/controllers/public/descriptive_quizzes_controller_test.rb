require 'test_helper'

class Public::DescriptiveQuizzesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get public_descriptive_quizzes_new_url
    assert_response :success
  end

  test 'should get show' do
    get public_descriptive_quizzes_show_url
    assert_response :success
  end

  test 'should get index' do
    get public_descriptive_quizzes_index_url
    assert_response :success
  end

  test 'should get edit' do
    get public_descriptive_quizzes_edit_url
    assert_response :success
  end
end
