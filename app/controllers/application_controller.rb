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
end
