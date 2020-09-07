require 'test_helper'

class WorkshopDatesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get workshop_dates_create_url
    assert_response :success
  end

  test "should get update" do
    get workshop_dates_update_url
    assert_response :success
  end

  test "should get destroy" do
    get workshop_dates_destroy_url
    assert_response :success
  end

end
