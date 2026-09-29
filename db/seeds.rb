# db/seeds.rb

puts "Cleaning database..."
RepairService.destroy_all
Repair.destroy_all
Bike.destroy_all
Customer.destroy_all
Mechanic.destroy_all
Service.destroy_all

puts "Creating mechanics / staff..."
m1 = Mechanic.create!(name: "Alex Rivera")
m2 = Mechanic.create!(name: "Sam Chen")
m3 = Mechanic.create!(name: "Jordan Taylor")
m4 = Mechanic.create!(name: "Taylor Morgan") # Counter/Reception

puts "Creating services (Wall List)..."
s_tuneup       = Service.create!(name: "Standard Tune-up", current_price: 75.00, is_active: true)
s_deluxe       = Service.create!(name: "Deluxe Overhaul", current_price: 150.00, is_active: true)
s_brake_adj    = Service.create!(name: "Brake Adjustment", current_price: 25.00, is_active: true)
s_brake_bleed  = Service.create!(name: "Hydraulic Brake Bleed", current_price: 45.00, is_active: true)
s_derailleur   = Service.create!(name: "Derailleur Adjustment", current_price: 30.00, is_active: true)
s_chain        = Service.create!(name: "Chain Replacement", current_price: 20.00, is_active: true)
s_flat         = Service.create!(name: "Flat Tire Fix", current_price: 15.00, is_active: true)
s_wheel_true   = Service.create!(name: "Wheel Truing", current_price: 35.00, is_active: true)
s_bottom_bkt   = Service.create!(name: "Bottom Bracket Service", current_price: 50.00, is_active: true)
s_headset      = Service.create!(name: "Headset Adjustment", current_price: 25.00, is_active: true)
s_cable_rep    = Service.create!(name: "Cable Replacement", current_price: 18.00, is_active: true)
s_drivetrain   = Service.create!(name: "Drivetrain Clean & Lube", current_price: 40.00, is_active: true)
s_susp_fork    = Service.create!(name: "Suspension Fork Service", current_price: 90.00, is_active: true)
s_rear_shock   = Service.create!(name: "Rear Shock Service", current_price: 85.00, is_active: true)
s_tubeless     = Service.create!(name: "Tubeless Conversion", current_price: 40.00, is_active: true)
s_bar_tape     = Service.create!(name: "Handlebar Tape Wrap", current_price: 22.00, is_active: true)
s_wheel_build  = Service.create!(name: "Custom Wheel Building", current_price: 110.00, is_active: true)
s_safety_insp  = Service.create!(name: "Safety Inspection", current_price: 30.00, is_active: true)
s_fender_inst  = Service.create!(name: "Fender Installation", current_price: 25.00, is_active: true)
s_rack_inst    = Service.create!(name: "Cargo Rack Installation", current_price: 25.00, is_active: true)
s_old_promo    = Service.create!(name: "Legacy Winter Checkup", current_price: 60.00, is_active: false)

puts "Creating customers..."
c1  = Customer.create!(name: "Carlos Mendoza", phone: "555-0101")
c2  = Customer.create!(name: "Elena Rostova", phone: "555-0102")
c3  = Customer.create!(name: "Marcus Vance", phone: "555-0103")
c4  = Customer.create!(name: "Sofia Rossi", phone: "555-0104")
c5  = Customer.create!(name: "David Kim", phone: "555-0105")
c6  = Customer.create!(name: "Hannah Abbott", phone: "555-0106")
c7  = Customer.create!(name: "Lucas Silva", phone: "555-0107")
c8  = Customer.create!(name: "Priya Patel", phone: "555-0108")
c9  = Customer.create!(name: "Oliver Queen", phone: "555-0109")
c10 = Customer.create!(name: "Amara Oke", phone: "555-0110")
c11 = Customer.create!(name: "No Repairs Customer", phone: "555-0199") # Customer with no repairs

puts "Creating bikes..."
b1  = Bike.create!(customer_id: c1.id, brand: "Trek", model: "Marlin 7", color: "Matte Black", serial_number: "TK100201")
b2  = Bike.create!(customer_id: c1.id, brand: "Specialized", model: "Sirrus X", color: "Navy Blue", serial_number: "SP300401") # c1 owns 2 bikes
b3  = Bike.create!(customer_id: c2.id, brand: "Giant", model: "Escape 3", color: "Red", serial_number: "GT500101")
b4  = Bike.create!(customer_id: c3.id, brand: "Cannondale", model: "Quick 4", color: "Emerald Green", serial_number: "CD900801")
b5  = Bike.create!(customer_id: c4.id, brand: "Trek", model: "FX 3", color: "Viper Red", serial_number: "TK880112")
b6  = Bike.create!(customer_id: c5.id, brand: "Trek", model: "Marlin 7", color: "Matte Black", serial_number: "TK100202") # Same make/model/color as b1
b7  = Bike.create!(customer_id: c6.id, brand: "Kona", model: "Dew Deluxe", color: "Gloss Grey", serial_number: "KN404100")
b8  = Bike.create!(customer_id: c7.id, brand: "Bianchi", model: "Via Nirone", color: "Celeste", serial_number: "BN707111")
b9  = Bike.create!(customer_id: c8.id, brand: "Surly", model: "Disc Trucker", color: "Stealth Blue", serial_number: "SR112233")
b10 = Bike.create!(customer_id: c9.id, brand: "Santa Cruz", model: "Chameleon", color: "Golden Yellow", serial_number: "SC554433")
b11 = Bike.create!(customer_id: c10.id, brand: "Scott", model: "Sub Cross", color: "Silver", serial_number: "ST998877")
b12 = Bike.create!(customer_id: c10.id, brand: "Brompton", model: "C Line", color: "Racing Green", serial_number: "BR332211")

puts "Creating repair orders..."
# 1. Received (not assigned, no agreement yet)
r1 = Repair.create!(bike_id: b1.id, mechanic_id: nil, status: "received", promised_on: Date.today + 3, customer_agreed: nil)
RepairService.create!(repair_id: r1.id, service_id: s_flat.id, price_charged: 15.00)

# 2. Quoted
r2 = Repair.create!(bike_id: b2.id, mechanic_id: m1.id, status: "quoted", promised_on: Date.today + 2, customer_agreed: nil)
RepairService.create!(repair_id: r2.id, service_id: s_brake_bleed.id, price_charged: 45.00)

# 3. Approved
r3 = Repair.create!(bike_id: b3.id, mechanic_id: m2.id, status: "approved", promised_on: Date.today + 1, customer_agreed: true)
RepairService.create!(repair_id: r3.id, service_id: s_tuneup.id, price_charged: 75.00)

# 4. In Progress
r4 = Repair.create!(bike_id: b4.id, mechanic_id: m3.id, status: "in_progress", promised_on: Date.today + 1, customer_agreed: true)
RepairService.create!(repair_id: r4.id, service_id: s_deluxe.id, price_charged: 150.00)

# 5. Ready
r5 = Repair.create!(bike_id: b5.id, mechanic_id: m1.id, status: "ready", promised_on: Date.today, customer_agreed: true)
RepairService.create!(repair_id: r5.id, service_id: s_chain.id, price_charged: 20.00)

# 6. Delivered
r6 = Repair.create!(bike_id: b6.id, mechanic_id: m2.id, status: "delivered", promised_on: Date.today - 2, handed_back_at: Time.current - 1.day, customer_agreed: true)
RepairService.create!(repair_id: r6.id, service_id: s_derailleur.id, price_charged: 30.00)

# 7. Rejected (Customer said no)
r7 = Repair.create!(bike_id: b7.id, mechanic_id: m1.id, status: "rejected", promised_on: Date.today + 1, customer_agreed: false)
RepairService.create!(repair_id: r7.id, service_id: s_susp_fork.id, price_charged: 90.00)

# 8. Overdue and not handed back (Promised date passed, still in progress)
r8 = Repair.create!(bike_id: b8.id, mechanic_id: m3.id, status: "in_progress", promised_on: Date.today - 3, handed_back_at: nil, customer_agreed: true)
RepairService.create!(repair_id: r8.id, service_id: s_wheel_true.id, price_charged: 35.00)

# 9. Same day in and out (Delivered today)
r9 = Repair.create!(bike_id: b9.id, mechanic_id: m1.id, status: "delivered", promised_on: Date.today, handed_back_at: Time.current, customer_agreed: true)
RepairService.create!(repair_id: r9.id, service_id: s_flat.id, price_charged: 15.00)

# 10. Multi-repair bike (First repair for b10 earlier)
r10 = Repair.create!(bike_id: b10.id, mechanic_id: m2.id, status: "delivered", promised_on: Date.today - 20, handed_back_at: Time.current - 19.days, customer_agreed: true)
RepairService.create!(repair_id: r10.id, service_id: s_tubeless.id, price_charged: 40.00)

# 11. Multi-repair bike (Second repair for b10 current)
r11 = Repair.create!(bike_id: b10.id, mechanic_id: m2.id, status: "ready", promised_on: Date.today + 1, customer_agreed: true)
RepairService.create!(repair_id: r11.id, service_id: s_brake_adj.id, price_charged: 25.00)

# 12. Historical Repair (Before last January, charged price differ from current list)
r12 = Repair.create!(bike_id: b11.id, mechanic_id: m1.id, status: "delivered", promised_on: Date.new(2025, 11, 15), handed_back_at: DateTime.new(2025, 11, 15, 17, 0), customer_agreed: true)
RepairService.create!(repair_id: r12.id, service_id: s_tuneup.id, price_charged: 60.00) # Current is 75.00

# 13. Multiple services (1 to 4 services) with DISCOUNT (charged below list price)
r13 = Repair.create!(bike_id: b12.id, mechanic_id: m3.id, status: "ready", promised_on: Date.today + 2, customer_agreed: true)
RepairService.create!(repair_id: r13.id, service_id: s_deluxe.id, price_charged: 130.00) # Discounted from 150.00
RepairService.create!(repair_id: r13.id, service_id: s_cable_rep.id, price_charged: 18.00)
RepairService.create!(repair_id: r13.id, service_id: s_drivetrain.id, price_charged: 40.00)

# 14. Additional active repair
r14 = Repair.create!(bike_id: b3.id, mechanic_id: m1.id, status: "received", promised_on: Date.today + 4, customer_agreed: nil)
RepairService.create!(repair_id: r14.id, service_id: s_fender_inst.id, price_charged: 25.00)

# 15. Additional active repair
r15 = Repair.create!(bike_id: b5.id, mechanic_id: m2.id, status: "quoted", promised_on: Date.today + 5, customer_agreed: nil)
RepairService.create!(repair_id: r15.id, service_id: s_rack_inst.id, price_charged: 25.00)

puts "Database successfully seeded!"