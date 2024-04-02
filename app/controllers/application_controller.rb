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
    
    return render_unauthorized('Unauthorized') if token.nil?

    decoded = JsonWebTokenService.decode(token)

    return render_unauthorized('Unauthorized') unless decoded

    current_user = User.find(decoded[:user_id])

    return render_unauthorized('Unauthorized') if current_user.nil?
  end

  private

  def extract_token_from_header
    header = request.headers['Authorization']
    header.split(' ').last if header.present?
  end

  def render_unauthorized(message)
    render json: { code: 401, error: message }, status: :unauthorized
  end
end
