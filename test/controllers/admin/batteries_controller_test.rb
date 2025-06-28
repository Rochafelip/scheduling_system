require "test_helper"

class Admin::BatteriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_batteries_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_batteries_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_batteries_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_batteries_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_batteries_update_url
    assert_response :success
  end
end
