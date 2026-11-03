class RepairsController < ApplicationController
  before_action :set_repair, only: [:show, :edit, :update, :destroy]

  def index
    authorize Repair
    @repairs = policy_scope(Repair).includes(:mechanic, bike: :customer)
  end

  def show
  end

  def new
    @repair = Repair.new
    authorize @repair
  end

  def edit
  end

  def create
    @repair = Repair.new
    authorize @repair
    @repair.assign_attributes(permitted_attributes(@repair))
    @repair.user = Current.user

    if @repair.save
      redirect_to @repair, notice: "Repair created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @repair.update(permitted_attributes(@repair))
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

  # Authorizes with the policy method that matches the action (show?, edit?, update?, destroy?).
  def set_repair
    @repair = Repair.find(params[:id])
    authorize @repair
  end
end