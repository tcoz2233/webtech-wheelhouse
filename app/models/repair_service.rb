class RepairService < ApplicationRecord
  belongs_to :repair
  belongs_to :service

  validates :price_charged, numericality: { greater_than: 0 }
end