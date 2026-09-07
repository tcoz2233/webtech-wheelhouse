# Domain Model — Wheelhouse Bicycle Shop

## 1. Entity-Relationship Diagram (ERD)

```dbml
// --- ROLES & USERS ---
Table customers {
  id integer [pk, increment]
  name varchar [not null]
  phone varchar [not null]
  created_at timestamp [not null]
  updated_at timestamp [not null]
}

Table mechanics {
  id integer [pk, increment]
  name varchar [not null]
  created_at timestamp [not null]
  updated_at timestamp [not null]
}

// --- BIKES & ASSETS ---
Table bikes {
  id integer [pk, increment]
  customer_id bigint [not null]
  brand varchar [not null]
  model varchar [not null]
  color varchar [not null]
  serial_number varchar [not null, unique]
  created_at timestamp [not null]
  updated_at timestamp [not null]
}

// --- CATALOG / SERVICE LIST (WALL LIST) ---
Table services {
  id integer [pk, increment]
  name varchar [not null, unique]
  current_price decimal(8,2) [not null]
  is_active boolean [not null, default: true]
  created_at timestamp [not null]
  updated_at timestamp [not null]
}

// --- REPAIRS & WORKSHOP LIFECYCLE ---
Table repairs {
  id integer [pk, increment]
  bike_id bigint [not null]
  mechanic_id bigint [null]
  status varchar [not null, default: 'received']
  promised_on date [not null]
  handed_back_at timestamp [null]
  customer_agreed boolean [null]
  created_at timestamp [not null]
  updated_at timestamp [not null]
}

Table repair_services {
  id integer [pk, increment]
  repair_id bigint [not null]
  service_id bigint [not null]
  price_charged decimal(8,2) [not null]
  created_at timestamp [not null]
  updated_at timestamp [not null]
}
2. Changes since Lab 3
Omitted photos table: Postponed to Lab 9 per assignment requirements.
Omitted diagnosis_notes column: Postponed to Lab 9 per assignment requirements.
Renamed repair_orders table to repairs: Aligned with standard Rails conventions and pluralized naming rules.
Renamed promised_day to promised_on: Adopted _on suffix convention for date-only columns.
Added handed_back_at column to repairs: Adopted _at suffix convention for tracking exact hand-back timestamps.
Added customer_agreed column to repairs: Explicit boolean column allowing NULL to record customer quote decisions.
Separated brand_model into brand, model, and color in bikes: Normalized bike details to better match real-world service requirements.
Added updated_at timestamps: Added standard Rails timestamps to all tables for lifecycle tracking.
Unique indices added: Enforced uniqueness on bikes.serial_number and services.name directly in the database.

3. Entity-to-Story Mapping
Entity Story IDD escription
customers US-01 Customer contact & identification
mechanics US-02 Mechanic assignment & workshop 
staffbikes US-03 Bike registration & owner tracking
services US-04 Wall list service catalog & pricing
repairs US-05 Repair order lifecycle & status updates
repair_services US-06 Line-item charging & price history