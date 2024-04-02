require 'swagger_helper'

RSpec.describe "Authentications", type: :request do
  let!(:user) { create :user }

  path '/api/v1/auth/login' do
    post '' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type:'string' },
          password: { type:'string' },
        },
        required: %w[ username password ]
      }
      response '200', '' do
        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end
      end
      response '401', '' do
        let(:user) { {username: 'invalid_username', password: 'invalid_password'} }
        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
