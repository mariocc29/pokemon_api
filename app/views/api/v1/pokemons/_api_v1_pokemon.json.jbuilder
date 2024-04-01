json.extract! api_v1_pokemon, :id, :name, :primary_type, :secondary_type, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary
json.url api_v1_pokemon_url(api_v1_pokemon, format: :json).sub('example.org', 'localhost')
