# frozen_string_literal: true

require 'test_helper'

module Public
  class TodayQuizzesControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get public_today_quizzes_index_url
      assert_response :success
    end
  end
end
