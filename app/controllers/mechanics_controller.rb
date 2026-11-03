class MechanicsController < ApplicationController
  def index
    authorize Mechanic
    @mechanics = policy_scope(Mechanic).by_name
  end

  def show
    @mechanic = Mechanic.find(params[:id])
    authorize @mechanic
    # Only the repairs the reader may read (same scope as the repairs index).
    @repairs = policy_scope(Repair).where(mechanic_id: @mechanic.id).includes(:bike)
  end
end