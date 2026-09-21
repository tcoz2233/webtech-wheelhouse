class RepairsController < ApplicationController
  def index
    @repairs = Repair.includes(bike: :customer).by_promised_date
  end

  def show
    @repair = Repair.includes(:bike, :mechanic, repair_services: :service).find(params[:id])
  end
end