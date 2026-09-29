class BikesController < ApplicationController
  before_action :set_bike, only: [:show, :edit, :update, :destroy]

  def index
    @bikes = Bike.includes(:customer).by_name
  end

  def show
  end

  def new
    @bike = Bike.new(customer_id: params[:customer_id])
  end

  def edit
  end

  def create
    @bike = Bike.new(bike_params)
    if @bike.save
      redirect_to @bike, notice: "Bike '#{@bike.serial_number}' created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bike.update(bike_params)
      redirect_to @bike, notice: "Bike '#{@bike.serial_number}' updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @bike.destroy
      redirect_to bikes_path, status: :see_other, notice: "Bike '#{@bike.serial_number}' deleted successfully."
    else
      redirect_to @bike, alert: @bike.errors.full_messages.to_sentence
    end
  end

  private

  def set_bike
    @bike = Bike.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end

  def bike_params
    params.expect(bike: [:brand, :model, :serial_number, :customer_id])
  rescue ActionController::ParameterMissing
    head :bad_request
  end
end