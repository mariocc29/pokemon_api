# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      # POST /login
      def login
        user = User.find_by_username(auth_params[:username])
        if user&.authenticate(auth_params[:password])
          token = JsonWebTokenService.encode(user_id: user.id)
          time = Time.now + 24.hours.to_i
          render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M') }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end

      private

      def auth_params
        params.permit(%i[username password])
      end
    end
  end
end
