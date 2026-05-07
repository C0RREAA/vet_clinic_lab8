class Pet < ApplicationRecord
  belongs_to :owner
  has_many :appointments
  has_one_attached :photo

  before_save :capitalize_name

  SPECIES = %w[dog cat rabbit bird reptile other].freeze
  ALLOWED_PHOTO_TYPES = %w[image/jpeg image/png image/webp].freeze
  MAX_PHOTO_SIZE = 5.megabytes

  scope :by_species, ->(species) { where(species: species) }

  validates :name,          presence: true
  validates :species,       presence: true, inclusion: { in: SPECIES }
  validates :date_of_birth, presence: true
  validates :weight,        presence: true, numericality: { greater_than: 0 }
  validates :owner,         presence: true

  validate :date_of_birth_not_in_future
  validate :acceptable_photo

  private

  def capitalize_name
    self.name = name.to_s.capitalize
  end

  def date_of_birth_not_in_future
    if date_of_birth.present? && date_of_birth > Date.today
      errors.add(:date_of_birth, "cannot be in the future")
    end
  end

  def acceptable_photo
    return unless photo.attached?

    unless ALLOWED_PHOTO_TYPES.include?(photo.content_type)
      errors.add(:photo, "must be a JPEG, PNG, or WebP image")
    end

    if photo.byte_size > MAX_PHOTO_SIZE
      errors.add(:photo, "must be smaller than 5 MB")
    end
  end
end
