require "test_helper"

class AppointmentTest < ActiveSupport::TestCase
  def valid_owner
    Owner.create!(first_name: "Test", last_name: "Owner",
                  email: "owner#{rand(9999)}@email.com", phone: "+56900000000")
  end

  def valid_pet(owner)
    Pet.create!(name: "Rex", species: "dog", breed: "Labrador",
                date_of_birth: "2020-01-01", weight: 10.0, owner: owner)
  end

  def valid_vet
    Vet.create!(first_name: "Diego", last_name: "Silva",
                email: "vet#{rand(9999)}@clinic.cl", phone: "+56900000000",
                specialization: "General")
  end

  def valid_appointment
    o = valid_owner
    Appointment.new(pet: valid_pet(o), vet: valid_vet,
                    date: Time.now + 1.day, reason: "Checkup",
                    status: :scheduled)
  end

  test "valid appointment can be saved" do
    assert valid_appointment.valid?
  end

  test "date is required" do
    a = valid_appointment
    a.date = nil
    assert_not a.valid?
    assert a.errors[:date].any?
  end

  test "reason is required" do
    a = valid_appointment
    a.reason = ""
    assert_not a.valid?
    assert_includes a.errors[:reason], "can't be blank"
  end

  test "pet is required" do
    a = valid_appointment
    a.pet = nil
    assert_not a.valid?
    assert a.errors[:pet].any?
  end

  test "vet is required" do
    a = valid_appointment
    a.vet = nil
    assert_not a.valid?
    assert a.errors[:vet].any?
  end

  test "status enum works correctly" do
    a = valid_appointment
    a.status = :completed
    assert a.completed?
  end
end