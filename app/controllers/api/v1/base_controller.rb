module Api
  module V1
    class BaseController < ActionController::API
      include ActionController::HttpAuthentication::Token::ControllerMethods

      # Manejo global de excepciones para mantener la forma estandarizada de errores (Req 5)
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      rescue_from ActionController::ParameterMissing, with: :render_bad_request

      private

      # Autenticación HTTP Bearer con comparación en tiempo constante (Req 6)
      def authenticate_token!
        authenticate_or_request_with_http_token do |token, _options|
          expected_token = Rails.application.credentials.api_bearer_token
          ActiveSupport::SecurityUtils.secure_compare(
            ::Digest::SHA256.hexdigest(token),
            ::Digest::SHA256.hexdigest(expected_token)
          )
        end || render_unauthorized
      end

      # Formato único de respuestas de error: { "errors": [...] } (Req 5)
      def render_error(messages, status:)
        messages = Array(messages)
        render json: { errors: messages }, status: status
      end

      def render_not_found
        render_error("Record not found", status: :not_found)
      end

      def render_bad_request(exception = nil)
        msg = exception ? exception.message : "Bad or missing parameters"
        render_error(msg, status: :bad_request)
      end

      def render_unauthorized
        render_error("Unauthorized: Invalid or missing token", status: :unauthorized)
      end
    end
  end
end