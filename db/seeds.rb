# Idempotent: from an empty database it finishes without errors, and running it again
# leaves the same number of rows in every table (nothing is destroyed, nothing is duplicated).
# Accounts are only created when missing, so their passwords never change.

# --- Staff ---------------------------------------------------------------
owner_staff   = Mechanic.find_or_create_by!(name: "Carlos Owner")
counter_staff = Mechanic.find_or_create_by!(name: "Ana Counter")
pedro         = Mechanic.find_or_create_by!(name: "Pedro Mechanic")
juan          = Mechanic.find_or_create_by!(name: "Juan Mechanic")

# --- Accounts ------------------------------------------------------------
seed_user = lambda do |email, password, role, staff|
  User.find_or_create_by!(email_address: email) do |u|
    u.password = password
    u.role = role
    u.mechanic = staff
  end
end

owner_user = seed_user.call("owner@wheelhouse.cl",    "passwordowner123",   "owner",    owner_staff)
seed_user.call("counter@wheelhouse.cl",               "passwordcounter123", "counter",  counter_staff)
seed_user.call("mechanic1@wheelhouse.cl",             "passwordmechanic1",  "mechanic", pedro)
seed_user.call("mechanic2@wheelhouse.cl",             "passwordmechanic2",  "mechanic", juan)
seed_user.call("orphan@wheelhouse.cl",                "passwordorphan123",  "counter",  nil)
# A mechanic account that belongs to no member of the staff: it has no repairs of its own.
seed_user.call("orphan.mechanic@wheelhouse.cl",       "passwordorphanmech1", "mechanic", nil)

# --- Services ------------------------------------------------------------
tune_up = Service.find_or_create_by!(name: "Tune-up") do |s|
  s.current_price = 35.00
  s.is_active = true
end
flat_tire = Service.find_or_create_by!(name: "Flat tire repair") do |s|
  s.current_price = 15.00
  s.is_active = true
end

# --- Customers and bikes -------------------------------------------------
maria = Customer.find_or_create_by!(name: "Maria Gomez") { |c| c.phone = "+56911111111" }
jose  = Customer.find_or_create_by!(name: "Jose Perez")  { |c| c.phone = "+56922222222" }

seed_bike = lambda do |serial, brand, model, color, customer|
  Bike.find_or_create_by!(serial_number: serial) do |b|
    b.brand = brand
    b.model = model
    b.color = color
    b.customer = customer
  end
end

bike1 = seed_bike.call("SN1001", "Trek",        "Marlin",  "Red",    maria)
bike2 = seed_bike.call("SN1002", "Specialized", "Sirrus",  "Blue",   jose)
bike3 = seed_bike.call("SN1003", "Giant",       "Talon",   "Black",  maria)
bike4 = seed_bike.call("SN1004", "Cannondale",  "Quick",   "Green",  jose)

# --- Repairs -------------------------------------------------------------
# Each mechanic has two repairs: one handed back (delivered) and one that is not.
# One repair has no mechanic assigned.
seed_repair = lambda do |bike, mechanic, status, promised_on|
  Repair.find_or_create_by!(bike: bike, mechanic: mechanic, status: status) do |r|
    r.promised_on = promised_on
    r.user = owner_user
    r.customer_agreed = true
    r.handed_back_at = Time.current if status == "delivered"
  end
end

pedro_done = seed_repair.call(bike1, pedro, "delivered",   Date.current - 7)
pedro_open   = seed_repair.call(bike3, pedro, "in_progress", Date.current - 2) # overdue
juan_done    = seed_repair.call(bike2, juan,  "delivered",   Date.current - 5)
juan_open    = seed_repair.call(bike4, juan,  "in_progress", Date.current + 5)
seed_repair.call(bike2, nil,   "received",    Date.current + 7)

[
  [pedro_done, tune_up],
  [pedro_open, flat_tire],
  [juan_done,  flat_tire],
  [juan_open,  tune_up]
].each do |repair, service|
  RepairService.find_or_create_by!(repair: repair, service: service) do |line|
    line.price_charged = service.current_price
  end
end