require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  describe 'validations' do
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
    
    it { should validate_presence_of(:name) }
    
    it 'validates uniqueness of name' do
      create(:pokemon, name: params[:name])
      pokemon = Pokemon.new(params)
      pokemon.valid?
      expect(pokemon.errors[:name]).to include('has already been taken')
    end

    it { should validate_presence_of(:primary_type) }
    it { should validate_presence_of(:total) }
    it { should validate_presence_of(:hp) }
    it { should validate_presence_of(:attack) }
    it { should validate_presence_of(:defense) }
    it { should validate_presence_of(:sp_atk) }
    it { should validate_presence_of(:sp_def) }
    it { should validate_presence_of(:speed) }
    it { should validate_presence_of(:generation) }
  end
end
