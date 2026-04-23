class Pet < ApplicationRecord
  belongs_to :owner
  has_many :appointments

  before_save :capitalize_name

  SPECIES = %w[dog cat rabbit bird reptile other].freeze

  scope :by_species, ->(species) { where(species: species) }

  validates :name,          presence: true
  validates :species,       presence: true, inclusion: { in: SPECIES }
  validates :date_of_birth, presence: true
  validates :weight,        presence: true, numericality: { greater_than: 0 }
  validates :owner,         presence: true

  validate :date_of_birth_not_in_future

  private

  def capitalize_name
    self.name = name.to_s.capitalize
  end

  def date_of_birth_not_in_future
    if date_of_birth.present? && date_of_birth > Date.today
      errors.add(:date_of_birth, "cannot be in the future")
    end
  end
end