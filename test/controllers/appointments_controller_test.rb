require "test_helper"

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    owner = Owner.create!(first_name: "Ana", last_name: "Martínez",
                          email: "ana#{rand(9999)}@email.com", phone: "+56912345678")
    pet = Pet.create!(name: "Firulais", species: "dog", breed: "Labrador",
                      date_of_birth: "2020-01-01", weight: 10.0, owner: owner)
    vet = Vet.create!(first_name: "Diego", last_name: "Silva",
                      email: "diego#{rand(9999)}@clinic.cl", phone: "+56922233344",
                      specialization: "Medicina General")
    @appointment = Appointment.create!(pet: pet, vet: vet,
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
end