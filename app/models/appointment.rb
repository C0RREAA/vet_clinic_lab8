class Appointment < ApplicationRecord
  belongs_to :pet
  belongs_to :vet
  has_many :treatments
end