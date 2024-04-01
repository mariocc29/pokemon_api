# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'application#forbidden_exception', via: :all

  namespace :api do
    namespace :v1 do
      resources :pokemons
    end
  end

  match '*path', to: 'application#route_not_found', via: :all
end
