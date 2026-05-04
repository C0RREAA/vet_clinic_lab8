require "test_helper"

class OwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = Owner.create!(first_name: "Ana", last_name: "Martínez",
                           email: "ana#{rand(99999)}@email.com", phone: "+56912345678")
  end

  test "should get index" do
    get owners_url
    assert_response :success
  end

  test "should get show" do
    get owner_url(@owner)
    assert_response :success
  end

  test "should get new" do
    get new_owner_url
    assert_response :success
  end

  test "should create owner with valid params" do
    assert_difference("Owner.count", 1) do
      post owners_url, params: { owner: {
        first_name: "Carlos", last_name: "Lopez",
        email: "carlos#{rand(99999)}@email.com", phone: "+56911111111"
      } }
    end
    assert_redirected_to owner_url(Owner.last)
    assert_equal "Owner was successfully created.", flash[:notice]
  end

  test "should not create owner with invalid params" do
    assert_no_difference("Owner.count") do
      post owners_url, params: { owner: {
        first_name: "", last_name: "", email: "bad", phone: ""
      } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_owner_url(@owner)
    assert_response :success
  end

  test "should update owner with valid params" do
    patch owner_url(@owner), params: { owner: { first_name: "Anita" } }
    assert_redirected_to owner_url(@owner)
    assert_equal "Anita", @owner.reload.first_name
  end

  test "should not update owner with invalid params" do
    patch owner_url(@owner), params: { owner: { email: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy owner" do
    assert_difference("Owner.count", -1) do
      delete owner_url(@owner)
    end
    assert_redirected_to owners_url
  end
end
