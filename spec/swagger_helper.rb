# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'PokemonApi V1 Docs',
        version: 'v1'
      },
      components: {
        securitySchemes: {
          bearer: {
            in: :header,
            name: :Authorization,
            type: :http,
            scheme: :bearer,
            required: true,
            description: 'Client Token',
            bearerFormat: 'JWT',
            tokenUrl: ENV.fetch('APP_URL', 'http://localhost') + '/api/v1/auth/login',
            scopes: {}
          }
        },
        schemas: {
          pokemon: {
            type: 'object',
              properties: {
                id: { type: 'integer' },
                name: { type:'string', nullable: false },
                primary_type: { type:'string', nullable: false },
                secondary_type: { type:'string', nullable: true },
                total: { type:'integer', nullable: false },
                hp: { type:'integer', nullable: false },
                attack: { type:'integer', nullable: false },
                defense: { type:'integer', nullable: false },
                sp_atk: { type:'integer', nullable: false },
                sp_def: { type:'integer', nullable: false },
                speed: { type:'integer', nullable: false },
                generation: { type:'integer', nullable: false },
                legendary: { type:'boolean', nullable: false },
                url: { type:'string', nullable: false },
              }
          },
          pokemons: {
            type: 'array',
            items: { '$ref' => '#/components/schemas/pokemon' }
          }
        }
      },
      paths: {},
      servers: [
        {
          url: ENV.fetch('APP_URL', 'http://localhost')
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :json
end
