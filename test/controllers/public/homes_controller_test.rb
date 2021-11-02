# frozen_string_literal: true

require 'test_helper'

module Public
  class HomesControllerTest < ActionDispatch::IntegrationTest
    test 'should get top' do
      get public_homes_top_url
      assert_response :success
    end
  end
end
