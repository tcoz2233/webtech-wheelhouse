class CustomersController < ApplicationController
  def index
    @customers = Customer.by_name
  end

  def show
    @customer = Customer.includes(bikes: :repairs).find(params[:id])
  end
end