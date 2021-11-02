# frozen_string_literal: true

require 'test_helper'

module Public
  class UsersControllerTest < ActionDispatch::IntegrationTest
    test 'should get show' do
      get public_users_show_url
      assert_response :success
    end

    test 'should get edit' do
      get public_users_edit_url
      assert_response :success
    end
  end
end
