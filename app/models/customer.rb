class Customer < ApplicationRecord
  has_many :bikes, dependent: :restrict_with_error
  has_many :repairs, through: :bikes

  validates :name, presence: true, allow_blank: false
  validates :phone, presence: true

  scope :by_name, -> { order(:name) }
end