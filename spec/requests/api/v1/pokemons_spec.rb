require 'rails_helper'

RSpec.describe Api::V1::PokemonsController, type: :request do
  include Rack::Test::Methods

  describe "GET /index" do
    let!(:pokemon) { create :pokemon }
    
    it "renders a successful response", :aggregate_failures do
      get 'api/v1/pokemons'

      expect(last_response).to be_successful
      expect(last_response.body).to include_json(
        [{
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
          url: "http://localhost/api/v1/pokemons/#{pokemon.id}"
        }]
      )
    end
  end

  describe "GET /show" do
    let!(:pokemon) { create :pokemon }

    it "renders a successful response" do
      get "api/v1/pokemons/#{pokemon.id}"
      expect(last_response).to be_successful
      expect(last_response.body).to include_json(
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
          url: "http://localhost/api/v1/pokemons/#{pokemon.id}"
        }
      )
    end
  end

  describe "POST /create" do
    subject { post 'api/v1/pokemons', params }
    
    context "with valid parameters" do
      let(:params) do
        {
          pokemon: {
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
        }
      end

      it "creates a new Pokemon", :aggregate_failures do
        expect { subject }.to change(Pokemon, :count).by(1)
        expect(last_response.status).to eql(201)
      end
    end

    context "with invalid parameters" do
      let(:params) { { invalid_key: true } }

      it "does not create a new Pokemon", :aggregate_failures do
        expect { subject }.to change(Pokemon, :count).by(0)
        expect(last_response.status).to eql(400)
      end
    end
  end

  describe "PATCH /update" do
    subject { patch "api/v1/pokemons/#{pokemon.id}", params }
    
    let!(:pokemon) { create :pokemon }

    context "with valid parameters" do
      let(:params) do
        {
          pokemon: {
            name: Faker::Games::Pokemon.name,
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
            legendary: pokemon.legendary
          }
        }
      end

      it "updates the requested pokemon", :aggregate_failures do
        subject
        response = JSON.parse(last_response.body)
        pokemon.reload

        expect(subject.status).to eql(200)
        expect(pokemon.name).to eql(params[:pokemon][:name])
        expect(response['name']).to eql(params[:pokemon][:name])
      end
    end

    context "with invalid parameters" do
      let(:params) { { invalid_key: true } }
      let(:pokemon_name) { pokemon.name }

      it "renders a JSON response with errors for the pokemon" do
        subject
        pokemon.reload
        expect(last_response.status).to eql(400)
        expect(pokemon.name).to eql(pokemon_name)
      end
    end
  end

  describe "DELETE /destroy" do
    subject { delete "api/v1/pokemons/#{pokemon.id}" }
    
    let!(:pokemon) { create :pokemon }

    it "destroys the requested pokemon" do
      expect { subject }.to change(Pokemon, :count).by(-1)
    end
  end
end
