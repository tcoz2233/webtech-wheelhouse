class Mechanic < ApplicationRecord
  scope :by_name, -> { order(:name) }
  has_many :repairs
end