# frozen_string_literal: true

require 'test_helper'

module Public
  class ResultsControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get public_results_index_url
      assert_response :success
    end
  end
end
