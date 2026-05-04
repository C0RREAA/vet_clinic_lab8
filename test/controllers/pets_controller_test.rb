require "test_helper"

class PetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = Owner.create!(first_name: "Ana", last_name: "Martínez",
                           email: "ana#{rand(99999)}@email.com", phone: "+56912345678")
    @pet = Pet.create!(name: "Firulais", species: "dog", breed: "Labrador",
                       date_of_birth: "2020-01-01", weight: 10.0, owner: @owner)
  end

  test "should get index" do
    get pets_url
    assert_response :success
  end

  test "should get show" do
    get pet_url(@pet)
    assert_response :success
  end

  test "should get new" do
    get new_pet_url
    assert_response :success
  end

  test "should create pet with valid params" do
    assert_difference("Pet.count", 1) do
      post pets_url, params: { pet: {
        name: "Rocky", species: "dog", breed: "Beagle",
        date_of_birth: "2021-05-10", weight: 8.5, owner_id: @owner.id
      } }
    end
    assert_redirected_to pet_url(Pet.last)
    assert_equal "Pet was successfully created.", flash[:notice]
  end

  test "should not create pet with invalid params" do
    assert_no_difference("Pet.count") do
      post pets_url, params: { pet: {
        name: "", species: "alien", weight: -1
      } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_pet_url(@pet)
    assert_response :success
  end

  test "should update pet with valid params" do
    patch pet_url(@pet), params: { pet: { name: "Firulin" } }
    assert_redirected_to pet_url(@pet)
    assert_equal "Firulin", @pet.reload.name
  end

  test "should not update pet with invalid params" do
    patch pet_url(@pet), params: { pet: { name: "", species: "alien" } }
    assert_response :unprocessable_entity
  end

  test "should destroy pet" do
    assert_difference("Pet.count", -1) do
      delete pet_url(@pet)
    end
    assert_redirected_to pets_url
  end
end
