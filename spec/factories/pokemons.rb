FactoryBot.define do
  factory :pokemon do
    name { "MyString" }
    primary_type { "MyString" }
    secondary_type { "MyString" }
    total { 1 }
    hp { 1 }
    attack { 1 }
    defense { 1 }
    sp_atk { 1 }
    sp_def { 1 }
    speed { 1 }
    generation { 1 }
    legendary { false }
  end
end
