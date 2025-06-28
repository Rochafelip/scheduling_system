require "test_helper"

class AvailabilitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get availabilities_index_url
    assert_response :success
  end
end
