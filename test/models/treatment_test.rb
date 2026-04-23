require "test_helper"

class TreatmentTest < ActiveSupport::TestCase
  def valid_appointment
    o = Owner.create!(first_name: "Test", last_name: "Owner",
                      email: "treat#{rand(9999)}@email.com", phone: "+56900000000")
    p = Pet.create!(name: "Michi", species: "cat", breed: "Persa",
                    date_of_birth: "2020-01-01", weight: 3.5, owner: o)
    v = Vet.create!(first_name: "Ana", last_name: "López",
                    email: "vet#{rand(9999)}@clinic.cl", phone: "+56900000001",
                    specialization: "General")
    Appointment.create!(pet: p, vet: v, date: Time.now + 1.day,
                        reason: "Checkup", status: :scheduled)
  end

  def valid_treatment
    Treatment.new(name: "Vacuna", administered_at: Time.now,
                  appointment: valid_appointment)
  end

  test "valid treatment can be saved" do
    assert valid_treatment.valid?
  end

  test "name is required" do
    t = valid_treatment
    t.name = ""
    assert_not t.valid?
    assert_includes t.errors[:name], "can't be blank"
  end

  test "administered_at is required" do
    t = valid_treatment
    t.administered_at = nil
    assert_not t.valid?
    assert t.errors[:administered_at].any?
  end

  test "appointment is required" do
    t = valid_treatment
    t.appointment = nil
    assert_not t.valid?
    assert t.errors[:appointment].any?
  end
end