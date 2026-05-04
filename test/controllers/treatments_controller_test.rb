require "test_helper"

class TreatmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = Owner.create!(first_name: "Ana", last_name: "Martínez",
                           email: "ana#{rand(99999)}@email.com", phone: "+56912345678")
    @pet = Pet.create!(name: "Firulais", species: "dog", breed: "Labrador",
                       date_of_birth: "2020-01-01", weight: 10.0, owner: @owner)
    @vet = Vet.create!(first_name: "Diego", last_name: "Silva",
                       email: "diego#{rand(99999)}@clinic.cl", phone: "+56922233344",
                       specialization: "Medicina General")
    @appointment = Appointment.create!(pet: @pet, vet: @vet,
                                       date: Time.now + 1.day,
                                       reason: "Checkup", status: :scheduled)
    @treatment = Treatment.create!(appointment: @appointment,
                                   name: "Antibiotic",
                                   medication: "Amoxicillin",
                                   dosage: "10mg",
                                   administered_at: Time.now,
                                   notes: "After lunch")
  end

  test "should get new" do
    get new_appointment_treatment_url(@appointment)
    assert_response :success
  end

  test "should create treatment with valid params" do
    assert_difference("Treatment.count", 1) do
      post appointment_treatments_url(@appointment), params: { treatment: {
        name: "Vaccine", medication: "Rabies",
        dosage: "1ml", administered_at: Time.now.iso8601, notes: ""
      } }
    end
    assert_redirected_to appointment_url(@appointment)
    assert_equal "Treatment was successfully created.", flash[:notice]
  end

  test "should not create treatment with invalid params" do
    assert_no_difference("Treatment.count") do
      post appointment_treatments_url(@appointment), params: { treatment: {
        name: "", administered_at: nil
      } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_appointment_treatment_url(@appointment, @treatment)
    assert_response :success
  end

  test "should update treatment with valid params" do
    patch appointment_treatment_url(@appointment, @treatment),
          params: { treatment: { name: "Updated treatment" } }
    assert_redirected_to appointment_url(@appointment)
    assert_equal "Updated treatment", @treatment.reload.name
  end

  test "should not update treatment with invalid params" do
    patch appointment_treatment_url(@appointment, @treatment),
          params: { treatment: { name: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy treatment" do
    assert_difference("Treatment.count", -1) do
      delete appointment_treatment_url(@appointment, @treatment)
    end
    assert_redirected_to appointment_url(@appointment)
  end
end
