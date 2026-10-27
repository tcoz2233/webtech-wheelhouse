module Api
  module V1
    class ServicesController < ApplicationController
      allow_unauthenticated_access

      def index
        @services = Service.all
        render json: @services.map { |service| serialize(service) }
      end

      def show
        @service = Service.find(params[:id])
        render json: serialize(@service)
      rescue ActiveRecord::RecordNotFound
        head :not_found
      end

      private

      def serialize(service)
        {
          id: service.id,
          name: service.name,
          price: service.current_price.to_s,
          is_active: service.is_active
        }
      end
    end
  end
end