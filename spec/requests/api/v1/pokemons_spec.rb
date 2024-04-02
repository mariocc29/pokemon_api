require 'swagger_helper'

RSpec.describe Api::V1::PokemonsController, type: :request do
  let(:user) { create :user }
  let(:Authorization) { "Bearer #{user.token}" }
  
  let(:expected_response) do
    {
      id: pokemon.id,
      name: pokemon.name,
      primary_type: pokemon.primary_type,
      secondary_type: pokemon.secondary_type,
      total: pokemon.total,
      hp: pokemon.hp,
      attack: pokemon.attack,
      defense: pokemon.defense,
      sp_atk: pokemon.sp_atk,
      sp_def: pokemon.sp_def,
      speed: pokemon.speed,
      generation: pokemon.generation,
      legendary: pokemon.legendary,
      url: match(/api\/v1\/pokemons\/#{pokemon.id}/)
    }
  end

  let(:params) do
    {
      name: Faker::Games::Pokemon.name,
      primary_type: 'Grass',
      secondary_type: 'Poison',
      total: Faker::Number.between(from: 100, to: 200),
      hp: Faker::Number.between(from: 100, to: 200),
      attack: Faker::Number.between(from: 100, to: 200),
      defense: Faker::Number.between(from: 100, to: 200),
      sp_atk: Faker::Number.between(from: 100, to: 200),
      sp_def: Faker::Number.between(from: 100, to: 200),
      speed: Faker::Number.between(from: 100, to: 200),
      generation: Faker::Number.between(from: 100, to: 200),
      legendary: Faker::Boolean.boolean
    }
  end

  path '/api/v1/pokemons' do
    get 'Retrieves a list of pokemons' do
      produces 'application/json'
      response '200', 'Returns a list of pokemons' do
        schema '$ref' => '#/components/schemas/pokemons'
        
        let!(:pokemon) { create :pokemon }
        
        run_test! do |response|
          expect(response).to be_successful
          expect(JSON.parse(response.body)).to include_json([expected_response])
        end
      end
    end

    post 'Creates a new pokemon' do
      consumes 'application/json'
      produces 'application/json'
      security [ bearer: [] ]
      parameter name: :pokemon, in: :body, schema: {
        type: :object,
        properties: {
          name: { type:'string' },
          primary_type: { type:'string' },
          secondary_type: { type:'string' },
          total: { type:'integer' },
          hp: { type:'integer' },
          attack: { type:'integer' },
          defense: { type:'integer' },
          sp_atk: { type:'integer' },
          sp_def: { type:'integer' },
          speed: { type:'integer' },
          generation: { type:'integer' },
          legendary: { type:'boolean' }
        },
        required: %w[ name primary_type total hp attack defense sp_atk sp_def speed generation legendary ]
      }
      response '201', 'Creates a new pokemon' do
        schema '$ref' => '#/components/schemas/pokemon'
        let(:pokemon) { params }

        run_test! do |response|
          expect(Pokemon.all.count).to eql(1)
          expect(response).to have_http_status(:created)
        end
      end
      response '400', 'Bad request' do 
        let(:pokemon) { { invalid_key: true } }
        
        run_test! do |response|
          expect(Pokemon.all.count).to eql(0)
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end

  path '/api/v1/pokemons/{id}' do
    parameter name: :id, in: :path, type: :string
    let(:id) { pokemon.id }

    get 'Retrieves a pokemon by id' do
      produces 'application/json'
      response '200', 'Returns a pokemon' do
        schema '$ref' => '#/components/schemas/pokemon'
        let!(:pokemon) { create :pokemon }
        
        run_test! do |response|
          expect(response).to be_successful
          expect(JSON.parse(response.body)).to include_json(expected_response)
        end
      end
      response '404', 'Pokemon not found' do
        let(:id) { 'invalid_id' }
        run_test! do |response|
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    patch 'Updates a pokemon' do
      consumes 'application/json'
      produces 'application/json'
      security [ bearer: [] ]
      parameter name: :pokemon, in: :body, schema: {
        type: :object,
        properties: {
          name: { type:'string' },
          primary_type: { type:'string' },
          secondary_type: { type:'string' },
          total: { type:'integer' },
          hp: { type:'integer' },
          attack: { type:'integer' },
          defense: { type:'integer' },
          sp_atk: { type:'integer' },
          sp_def: { type:'integer' },
          speed: { type:'integer' },
          generation: { type:'integer' },
          legendary: { type:'boolean' }
        },
        required: %w[ name primary_type total hp attack defense sp_atk sp_def speed generation legendary ]
      }
      response '200', 'Updates the pokemon' do
        schema '$ref' => '#/components/schemas/pokemon'
        let!(:factory_pokemon) { create :pokemon }
        let(:id) { factory_pokemon.id }
        let(:pokemon) { params }

        run_test! do |response|
          factory_pokemon.reload

          expect(response).to be_successful
          expect(factory_pokemon.name).to eql(pokemon[:name])
          expect(JSON.parse(response.body)['name']).to eql(pokemon[:name])
        end
      end
      response '400', 'Bad request' do 
        let!(:factory_pokemon) { create :pokemon }
        let(:id) { factory_pokemon.id }
        let(:pokemon) { { invalid_key: true } }

        run_test! do |response|
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    delete 'Deletes a pokemon' do
      produces 'application/json'
      security [ bearer: [] ]
      response '204', 'Deletes the pokemon' do
        let!(:pokemon) { create :pokemon }

        run_test! do |response|
          expect(response).to have_http_status(:no_content)
          expect(Pokemon.all.count).to eql(0)
        end
      end
      response '404', 'Not found' do 
        let(:id) { 'invalid_id' }
        run_test! do |response|
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
