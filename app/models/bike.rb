class Bike < ApplicationRecord
  belongs_to :customer
  has_many :repairs, dependent: :destroy

  validates :brand, :model, :serial_number, :color, presence: true
  validates :serial_number, uniqueness: { case_sensitive: false }

  before_validation :normalize_serial_number

  scope :by_name, -> { order(:brand, :model) }

  private

  def normalize_serial_number
    self.serial_number = serial_number.strip.upcase if serial_number.present?
  end
end