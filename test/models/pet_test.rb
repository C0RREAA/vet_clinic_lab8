require "test_helper"

class PetTest < ActiveSupport::TestCase
  def valid_owner
    Owner.create!(first_name: "Test", last_name: "Owner",
                  email: "test#{rand(9999)}@email.com", phone: "+56900000000")
  end

  def valid_pet(owner: nil)
    Pet.new(name: "Firulais", species: "dog", breed: "Labrador",
            date_of_birth: "2020-01-01", weight: 10.0,
            owner: owner || valid_owner)
  end

  test "valid pet can be saved" do
    assert valid_pet.valid?
  end

  test "name is required" do
    p = valid_pet
    p.name = ""
    assert_not p.valid?
    assert_includes p.errors[:name], "can't be blank"
  end

  test "species is required" do
    p = valid_pet
    p.species = ""
    assert_not p.valid?
    assert p.errors[:species].any?
  end

  test "species must be valid" do
    p = valid_pet
    p.species = "dragon"
    assert_not p.valid?
    assert p.errors[:species].any?
  end

  test "date_of_birth is required" do
    p = valid_pet
    p.date_of_birth = nil
    assert_not p.valid?
    assert_includes p.errors[:date_of_birth], "can't be blank"
  end

  test "date_of_birth cannot be in the future" do
    p = valid_pet
    p.date_of_birth = Date.tomorrow
    assert_not p.valid?
    assert p.errors[:date_of_birth].any?
  end

  test "weight is required" do
    p = valid_pet
    p.weight = nil
    assert_not p.valid?
    assert p.errors[:weight].any?
  end

  test "weight must be greater than 0" do
    p = valid_pet
    p.weight = 0
    assert_not p.valid?
    assert p.errors[:weight].any?
  end

  test "owner is required" do
    p = valid_pet
    p.owner = nil
    assert_not p.valid?
    assert p.errors[:owner].any?
  end

  test "name is capitalized before save" do
    p = valid_pet
    p.name = "firulais"
    p.save!
    assert_equal "Firulais", p.name
  end
end