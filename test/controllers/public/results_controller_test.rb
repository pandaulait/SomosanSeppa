require 'test_helper'

class Public::ResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_results_index_url
    assert_response :success
  end

end
