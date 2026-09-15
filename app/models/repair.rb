
class Repair < ApplicationRecord
  belongs_to :bike
  belongs_to :mechanic, optional: true 
  
  has_many :repair_services
  has_many :services, through: :repair_services
end