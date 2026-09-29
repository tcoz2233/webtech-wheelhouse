class Service < ApplicationRecord
  has_many :repair_services, dependent: :restrict_with_error
  has_many :repairs, through: :repair_services

  validates :name, presence: true
  validates :current_price, numericality: { greater_than: 0 }

  scope :by_name, -> { order(:name) }
  scope :active, -> { where(is_active: true) }
end