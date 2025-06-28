require "test_helper"

class Admin::AvailabilitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_availabilities_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_availabilities_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_availabilities_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_availabilities_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_availabilities_update_url
    assert_response :success
  end
end
