# frozen_string_literal: true

class ApplicationController < ActionController::API
  # The `forbidden_exception` method is responsible for raising a `ForbiddenException`
  # to indicate insufficient permissions, triggering the handle_application_exception method.
  def forbidden_exception
    render json: { code: 403, error: 'Forbidden' }, status: :forbidden
  end

  # The `route_not_found` method is responsible for raising a `RoutingException` when a route is not found.
  def route_not_found
    render json: { code: 404, error: 'Route Not Found' }, status: :not_found
  end

  protected

  # The `authorize_request` method is responsible for authorizing user requests. 
  # we need to get a token in the header with ‘Authorization’ as a key.
  def authorize_request
    token = extract_token_from_header

    begin
      @decoded = JsonWebTokenService.decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private

  def extract_token_from_header
    header = request.headers['Authorization']
    header.split(' ').last if header.present?
  end
end
