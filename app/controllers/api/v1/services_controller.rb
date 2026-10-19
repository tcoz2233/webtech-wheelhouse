module Api
  module V1
    class ServicesController < BaseController
      # Requerimiento 6: GET es público, POST requiere Bearer token
      before_action :authenticate_token!, only: [:create]

      # GET /api/v1/services (Requerimiento 2 y 7)
      def index
        services = Service.left_joins(:repair_services)
                          .select("services.*, COUNT(repair_services.id) AS repairs_count")
                          .group("services.id")
                          .order(:name)

        render json: services.map { |service| serialize_service(service) }, status: :ok
      end

      # GET /api/v1/services/:id (Requerimiento 2)
      def show
        service = Service.left_joins(:repair_services)
                         .select("services.*, COUNT(repair_services.id) AS repairs_count")
                         .group("services.id")
                         .find(params[:id])

        render json: serialize_service(service), status: :ok
      end

      # POST /api/v1/services (Requerimiento 4)
      def create
        service = Service.new(service_params)

        if service.save
          render json: serialize_service(service),
                 status: :created,
                 location: api_v1_service_url(service)
        else
          render_error(service.errors.full_messages, status: :unprocessable_entity)
        end
      end

      private

      # Requerimiento 4: Strong parameters
      def service_params
        params.require(:service).permit(:name, :price)
      end

      # Requerimiento 2: Documento escrito explícitamente en el controlador
      def serialize_service(service)
        count = service.respond_to?(:repairs_count) ? service.repairs_count.to_i : service.repair_services.count
        {
          id: service.id,
          name: service.name,
          price: service.price.to_s, # Se envía como String para evitar imprecisiones de flotante
          repairs_count: count
        }
      end
    end
  end
end