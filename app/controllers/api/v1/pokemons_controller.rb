# frozen_string_literal: true

module Api
  module V1
    class PokemonsController < ApplicationController
      before_action :authorize_request, except: %i[index show]
      before_action :set_pokemon, only: %i[show update destroy]

      # GET /pokemons
      def index
        @pokemons = Pokemon.all
      end

      # GET /pokemons/1
      def show; end

      # POST /pokemons
      def create
        @pokemon = Pokemon.new(pokemon_params)

        if @pokemon.save
          render json: @pokemon, status: :created, location: api_v1_pokemon_url(@pokemon)
        else
          render json: @pokemon.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /pokemons/1
      def update
        if @pokemon.update(pokemon_params)
          render json: @pokemon, status: :ok, location: api_v1_pokemon_url(@pokemon)
        else
          render json: @pokemon.errors, status: :unprocessable_entity
        end
      end

      # DELETE /pokemons/1
      def destroy
        @pokemon.destroy!
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_pokemon
        @pokemon = Pokemon.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def pokemon_params
        params.require(:pokemon).permit(%i[name primary_type secondary_type total hp attack defense sp_atk sp_def speed generation legendary])
      end
    end
  end
end
