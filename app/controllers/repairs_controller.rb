class RepairsController < ApplicationController
  before_action :set_repair, only: [:show, :edit, :update, :destroy]

  def index
    @repairs = Repair.includes(bike: :customer).by_promised_date
  end

  def show
  end

  def new
    @repair = Repair.new(bike_id: params[:bike_id])
    3.times { @repair.repair_services.build }
  end

  def edit
    @repair.repair_services.build
  end

  def create
    @repair = Repair.new(repair_params)
    if @repair.save
      redirect_to @repair, notice: "Repair ##{@repair.id} for bike '#{@repair.bike.serial_number}' created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @repair.update(repair_params)
      redirect_to @repair, notice: "Repair ##{@repair.id} updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @repair.destroy
      redirect_to repairs_path, status: :see_other, notice: "Repair ##{@repair.id} deleted successfully."
    else
      redirect_to @repair, alert: @repair.errors.full_messages.to_sentence
    end
  end

  private

  def set_repair
    @repair = Repair.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end

  def repair_params
    params.expect(repair: [
      :bike_id,
      :mechanic_id,
      :status,
      :promised_on,
      :customer_agreed,
      :handed_back_at,
      repair_services_attributes: [:id, :service_id, :price_charged, :_destroy]
    ])
  rescue ActionController::ParameterMissing
    head :bad_request
  end
end