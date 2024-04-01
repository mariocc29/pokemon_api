require "rails_helper"

RSpec.describe Api::V1::PokemonsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/pokemons").to route_to("api/v1/pokemons#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/pokemons/1").to route_to("api/v1/pokemons#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/pokemons").to route_to("api/v1/pokemons#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/pokemons/1").to route_to("api/v1/pokemons#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/pokemons/1").to route_to("api/v1/pokemons#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/pokemons/1").to route_to("api/v1/pokemons#destroy", id: "1")
    end
  end
end
