require "test_helper"

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
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
  end

  test "should get index" do
    get appointments_url
    assert_response :success
  end

  test "should get show" do
    get appointment_url(@appointment)
    assert_response :success
  end

  test "should get new" do
    get new_appointment_url
    assert_response :success
  end

  test "should create appointment with valid params" do
    assert_difference("Appointment.count", 1) do
      post appointments_url, params: { appointment: {
        pet_id: @pet.id, vet_id: @vet.id,
        date: (Time.now + 2.days).iso8601,
        reason: "Vaccination", status: "scheduled"
      } }
    end
    assert_redirected_to appointment_url(Appointment.last)
    assert_equal "Appointment was successfully created.", flash[:notice]
  end

  test "should not create appointment with invalid params" do
    assert_no_difference("Appointment.count") do
      post appointments_url, params: { appointment: {
        pet_id: nil, vet_id: nil, date: nil, reason: ""
      } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_appointment_url(@appointment)
    assert_response :success
  end

  test "should update appointment with valid params" do
    patch appointment_url(@appointment), params: { appointment: { reason: "Updated reason" } }
    assert_redirected_to appointment_url(@appointment)
    assert_equal "Updated reason", @appointment.reload.reason
  end

  test "should not update appointment with invalid params" do
    patch appointment_url(@appointment), params: { appointment: { reason: "", date: nil } }
    assert_response :unprocessable_entity
  end

  test "should destroy appointment" do
    assert_difference("Appointment.count", -1) do
      delete appointment_url(@appointment)
    end
    assert_redirected_to appointments_url
  end
end
