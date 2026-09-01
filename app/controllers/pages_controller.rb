class PagesController < ApplicationController
  def home
  end

  def services
    @services = [
      { name: "Basic Tune-Up", price: 50.00 },
      { name: "Full Overhaul", price: 120.00 },
      { name: "Brake Bleed (Front or Rear)", price: 35.00 },
      { name: "Wheel Truing", price: 25.00 },
      { name: "Chain Replacement", price: 20.00 },
      { name: "Flat Tire Repair / Tube Swap", price: 15.00 },
      { name: "Bottom Bracket Service", price: 40.00 },
      { name: "Drivetrain Clean & Degrease", price: 45.00 },
      { name: "Gear Alignment & Adjustment", price: 25.00 },
      { name: "Headset Adjustment / Service", price: 30.00 },
      { name: "Custom Wheel Build", price: 80.00 },
      { name: "Bike Assembly from Box", price: 90.00 }
    ]
  end

  def visiting
  end

  def about
  end
end