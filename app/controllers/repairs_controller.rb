class RepairsController < ApplicationController
  before_action :set_repair, only: [:show, :edit, :update, :destroy]

  def index
    @repairs = Repair.includes(:bike, :mechanic, :user).all
  end

  def show
  end

  def new
    @repair = Repair.new
  end

  def edit
  end

  def create
    @repair = Repair.new(repair_params)
    @repair.user = Current.user

    if @repair.save
      redirect_to @repair, notice: "Repair created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @repair.update(repair_params)
      redirect_to @repair, notice: "Repair updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @repair.destroy
    redirect_to repairs_path, status: :see_other, notice: "Repair deleted successfully."
  end

  private

  def set_repair
    @repair = Repair.find(params[:id])
  end

  def repair_params
    params.expect(repair: [:bike_id, :mechanic_id, :promised_on, :status, :customer_agreed])
  end
end