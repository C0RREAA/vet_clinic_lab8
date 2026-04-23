require "test_helper"

class PetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = Owner.create!(first_name: "Ana", last_name: "Martínez",
                           email: "ana#{rand(9999)}@email.com", phone: "+56912345678")
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
end