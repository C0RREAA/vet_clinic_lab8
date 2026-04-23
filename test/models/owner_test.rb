require "test_helper"

class OwnerTest < ActiveSupport::TestCase
  def valid_owner
    Owner.new(first_name: "Ana", last_name: "Martínez",
              email: "ana@email.com", phone: "+56912345678")
  end

  test "valid owner can be saved" do
    assert valid_owner.valid?
  end

  test "first_name is required" do
    o = valid_owner
    o.first_name = ""
    assert_not o.valid?
    assert_includes o.errors[:first_name], "can't be blank"
  end

  test "last_name is required" do
    o = valid_owner
    o.last_name = ""
    assert_not o.valid?
    assert_includes o.errors[:last_name], "can't be blank"
  end

  test "email is required" do
    o = valid_owner
    o.email = ""
    assert_not o.valid?
    assert_includes o.errors[:email], "can't be blank"
  end

  test "email must have valid format" do
    o = valid_owner
    o.email = "notanemail"
    assert_not o.valid?
    assert o.errors[:email].any?
  end

  test "email must be unique" do
    valid_owner.save!
    o2 = valid_owner
    assert_not o2.valid?
    assert_includes o2.errors[:email], "has already been taken"
  end

  test "phone is required" do
    o = valid_owner
    o.phone = ""
    assert_not o.valid?
    assert_includes o.errors[:phone], "can't be blank"
  end

  test "email is normalized to lowercase" do
    o = valid_owner
    o.email = "  ANA@EMAIL.COM  "
    o.valid?
    assert_equal "ana@email.com", o.email
  end
end