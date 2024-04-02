require 'swagger_helper'

RSpec.describe "Authentications", type: :request do
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
        let(:user) { {username: 'username', password: 'password'} }
        
        before do
          create :user
        end
        
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to include_json({
            token: /\A[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+\z/,
            expires_at: /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}\z/
          })
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
