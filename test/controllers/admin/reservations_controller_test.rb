require "test_helper"

class Admin::ReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_reservations_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_reservations_show_url
    assert_response :success
  end
end
