require "test_helper"

class VetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vet = Vet.create!(first_name: "Diego", last_name: "Silva",
                       email: "diego#{rand(9999)}@clinic.cl", phone: "+56922233344",
                       specialization: "Medicina General")
  end

  test "should get index" do
    get vets_url
    assert_response :success
  end

  test "should get show" do
    get vet_url(@vet)
    assert_response :success
  end
end