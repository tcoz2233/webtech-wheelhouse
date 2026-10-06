class RepairsController < ApplicationController
  before_action :set_repair, only: [:show, :edit, :update, :destroy]

  def index
    # Requerimiento 8: Preloading para evitar N+1
    @repairs = Repair.includes(:bike, :mechanic)
                     .with_attached_photos
                     .with_all_rich_text
                     .order(created_at: :desc)
  end

  def show
  end

  def new
    @repair = Repair.new
  end

  def create
    @repair = Repair.new(repair_params)
    if @repair.save
      redirect_to @repair, notice: "Repair created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # Requerimiento 3: Añadir fotos sin borrar las actuales
    if params[:repair][:photos].present?
      @repair.photos.attach(params[:repair][:photos])
    end

    if @repair.update(repair_params.except(:photos))
      redirect_to @repair, notice: "Repair updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @repair.destroy
    redirect_to repairs_path, notice: "Repair deleted successfully."
  end

  private

  def set_repair
    @repair = Repair.find(params[:id])
  end

  def repair_params
    params.require(:repair).permit(:bike_id, :mechanic_id, :status, :diagnosis, photos: [])
  end
end