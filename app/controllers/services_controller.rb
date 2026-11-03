class ServicesController < ApplicationController
  # The list and the page stay public; ServicePolicy#index? and #show? allow a visitor.
  allow_unauthenticated_access only: [:index, :show]
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def index
    authorize Service
    @services = policy_scope(Service).by_name
  end

  def show
    # Only the repairs the reader may read (same scope as the repairs index).
    @repairs = policy_scope(Repair)
                 .where(id: @service.repair_services.select(:repair_id))
                 .includes(bike: :customer)
  end

  def new
    @service = Service.new
    authorize @service
  end

  def edit
  end

  def create
    @service = Service.new
    authorize @service
    @service.assign_attributes(service_params)
    if @service.save
      redirect_to @service, notice: "Service '#{@service.name}' created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @service.update(service_params)
      redirect_to @service, notice: "Service '#{@service.name}' updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @service.destroy
      redirect_to services_path, status: :see_other, notice: "Service '#{@service.name}' deleted successfully."
    else
      redirect_to @service, alert: @service.errors.full_messages.to_sentence
    end
  end

  private

  def set_service
    @service = Service.find(params[:id])
    authorize @service
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end

  def service_params
    params.expect(service: [:name, :current_price, :is_active])
  rescue ActionController::ParameterMissing
    head :bad_request
  end
end