FactoryBot.define do
  factory :pokemon do
    name { Faker::Games::Pokemon.name }
    primary_type { 'Grass' }
    secondary_type { 'Poison' }
    total { Faker::Number.between(from: 100, to: 200) }
    hp { Faker::Number.between(from: 100, to: 200) }
    attack { Faker::Number.between(from: 100, to: 200) }
    defense { Faker::Number.between(from: 100, to: 200) }
    sp_atk { Faker::Number.between(from: 100, to: 200) }
    sp_def { Faker::Number.between(from: 100, to: 200) }
    speed { Faker::Number.between(from: 100, to: 200) }
    generation { Faker::Number.between(from: 1, to: 6) }
    legendary { Faker::Boolean.boolean }

    trait :with_null_secondary_type do
      secondary_type { nil }
    end
  end
end
