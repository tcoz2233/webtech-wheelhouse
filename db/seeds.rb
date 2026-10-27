RepairService.destroy_all
Repair.destroy_all
Bike.destroy_all
Customer.destroy_all
Service.destroy_all
User.destroy_all
Mechanic.destroy_all

owner_mechanic = Mechanic.find_or_create_by!(name: "Carlos Owner")
counter_mechanic = Mechanic.find_or_create_by!(name: "Ana Counter")
mechanic1 = Mechanic.find_or_create_by!(name: "Pedro Mechanic")
mechanic2 = Mechanic.find_or_create_by!(name: "Juan Mechanic")

User.find_or_create_by!(email_address: "owner@wheelhouse.cl") do |u|
  u.password = "passwordowner123"
  u.role = "owner"
  u.mechanic = owner_mechanic
end

User.find_or_create_by!(email_address: "counter@wheelhouse.cl") do |u|
  u.password = "passwordcounter123"
  u.role = "counter"
  u.mechanic = counter_mechanic
end

User.find_or_create_by!(email_address: "mechanic1@wheelhouse.cl") do |u|
  u.password = "passwordmechanic1"
  u.role = "mechanic"
  u.mechanic = mechanic1
end

User.find_or_create_by!(email_address: "orphan@wheelhouse.cl") do |u|
  u.password = "passwordorphan123"
  u.role = "counter"
  u.mechanic = nil
end

service1 = Service.find_or_create_by!(name: "Tune-up", current_price: 35.00, is_active: true)
service2 = Service.find_or_create_by!(name: "Flat tire repair", current_price: 15.00, is_active: true)

customer1 = Customer.find_or_create_by!(name: "Maria Gomez", phone: "+56911111111")
customer2 = Customer.find_or_create_by!(name: "Jose Perez", phone: "+56922222222")

bike1 = Bike.find_or_create_by!(serial_number: "SN1001", brand: "Trek", model: "Marlin", color: "Red", customer: customer1)
bike2 = Bike.find_or_create_by!(serial_number: "SN1002", brand: "Specialized", model: "Sirrus", color: "Blue", customer: customer2)

admin_user = User.find_by(email_address: "owner@wheelhouse.cl")

repair1 = Repair.find_or_create_by!(bike: bike1, promised_on: 3.days.from_now, status: "received") do |r|
  r.mechanic = mechanic1
  r.user = admin_user
  r.customer_agreed = true
end

repair2 = Repair.find_or_create_by!(bike: bike2, promised_on: 5.days.from_now, status: "in_progress") do |r|
  r.mechanic = mechanic2
  r.user = nil
  r.customer_agreed = true
end

RepairService.find_or_create_by!(repair: repair1, service: service1, price_charged: service1.current_price)
RepairService.find_or_create_by!(repair: repair2, service: service2, price_charged: service2.current_price)