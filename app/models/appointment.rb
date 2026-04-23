class Appointment < ApplicationRecord
  belongs_to :pet
  belongs_to :vet
  has_many :treatments

  enum :status, { scheduled: 0, in_progress: 1, completed: 2, cancelled: 3 }

  scope :upcoming, -> { where("date > ?", Time.now).order(:date) }
  scope :past,     -> { where("date < ?", Time.now).order(date: :desc) }

  validates :date,   presence: true
  validates :reason, presence: true
  validates :pet,    presence: true
  validates :vet,    presence: true
  validates :status, presence: true
end