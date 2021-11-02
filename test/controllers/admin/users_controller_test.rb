# frozen_string_literal: true

require 'test_helper'

module Admin
  class UsersControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get admin_users_index_url
      assert_response :success
    end
  end
end
