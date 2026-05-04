require "test_helper"

class VetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vet = Vet.create!(first_name: "Diego", last_name: "Silva",
                       email: "diego#{rand(99999)}@clinic.cl", phone: "+56922233344",
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

  test "should get new" do
    get new_vet_url
    assert_response :success
  end

  test "should create vet with valid params" do
    assert_difference("Vet.count", 1) do
      post vets_url, params: { vet: {
        first_name: "Maria", last_name: "Perez",
        email: "maria#{rand(99999)}@clinic.cl", phone: "+56933344455",
        specialization: "Cirugía"
      } }
    end
    assert_redirected_to vet_url(Vet.last)
    assert_equal "Vet was successfully created.", flash[:notice]
  end

  test "should not create vet with invalid params" do
    assert_no_difference("Vet.count") do
      post vets_url, params: { vet: {
        first_name: "", last_name: "", email: "bad", specialization: ""
      } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_vet_url(@vet)
    assert_response :success
  end

  test "should update vet with valid params" do
    patch vet_url(@vet), params: { vet: { specialization: "Dermatología" } }
    assert_redirected_to vet_url(@vet)
    assert_equal "Dermatología", @vet.reload.specialization
  end

  test "should not update vet with invalid params" do
    patch vet_url(@vet), params: { vet: { email: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy vet" do
    assert_difference("Vet.count", -1) do
      delete vet_url(@vet)
    end
    assert_redirected_to vets_url
  end
end
