require "test_helper"

class VetTest < ActiveSupport::TestCase
  def valid_vet
    Vet.new(first_name: "Diego", last_name: "Silva",
            email: "diego@vetclinic.cl", phone: "+56922233344",
            specialization: "Medicina General")
  end

  test "valid vet can be saved" do
    assert valid_vet.valid?
  end

  test "first_name is required" do
    v = valid_vet
    v.first_name = ""
    assert_not v.valid?
    assert_includes v.errors[:first_name], "can't be blank"
  end

  test "last_name is required" do
    v = valid_vet
    v.last_name = ""
    assert_not v.valid?
    assert_includes v.errors[:last_name], "can't be blank"
  end

  test "email is required" do
    v = valid_vet
    v.email = ""
    assert_not v.valid?
    assert v.errors[:email].any?
  end

  test "email must have valid format" do
    v = valid_vet
    v.email = "notvalid"
    assert_not v.valid?
    assert v.errors[:email].any?
  end

  test "email must be unique" do
    valid_vet.save!
    v2 = valid_vet
    assert_not v2.valid?
    assert_includes v2.errors[:email], "has already been taken"
  end

  test "specialization is required" do
    v = valid_vet
    v.specialization = ""
    assert_not v.valid?
    assert_includes v.errors[:specialization], "can't be blank"
  end

  test "email is normalized to lowercase" do
    v = valid_vet
    v.email = "  DIEGO@VETCLINIC.CL  "
    v.valid?
    assert_equal "diego@vetclinic.cl", v.email
  end
end