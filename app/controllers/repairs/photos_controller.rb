module Repairs
  class PhotosController < ApplicationController
    def destroy
      @repair = Repair.find(params[:repair_id])
      photo = @repair.photos.find(params[:id])
      photo.purge # Elimina tanto el registro en BD como el archivo físico
      redirect_to repair_path(@repair), notice: "Photo removed successfully."
    end
  end
end