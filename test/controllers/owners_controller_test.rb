require "test_helper"

class OwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = Owner.create!(first_name: "Ana", last_name: "Martínez",
                           email: "ana#{rand(9999)}@email.com", phone: "+56912345678")
  end

  test "should get index" do
    get owners_url
    assert_response :success
  end

  test "should get show" do
    get owner_url(@owner)
    assert_response :success
  end
end