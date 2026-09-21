class ServicesController < ApplicationController
  def index
    @services = Service.by_name
  end

  def show
    @service = Service.includes(repairs: { bike: :customer }).find(params[:id])
  end
end