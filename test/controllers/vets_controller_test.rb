require "test_helper"

class VetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vets_index_url
    assert_response :success
  end

  test "should get show" do
    get vets_show_url
    assert_response :success
  end
end
