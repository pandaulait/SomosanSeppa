# frozen_string_literal: true

require 'test_helper'

module Public
  class QuizzesControllerTest < ActionDispatch::IntegrationTest
    test 'should get show' do
      get public_quizzes_show_url
      assert_response :success
    end

    test 'should get new' do
      get public_quizzes_new_url
      assert_response :success
    end

    test 'should get edit' do
      get public_quizzes_edit_url
      assert_response :success
    end

    test 'should get index' do
      get public_quizzes_index_url
      assert_response :success
    end
  end
end
