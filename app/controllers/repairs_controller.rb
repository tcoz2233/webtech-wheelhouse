class RepairsController < ApplicationController
  def index
    @repairs = Repair.all
  end

  def show
    @repair = Repair.find(params[:id])
  end
end