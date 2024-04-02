FactoryBot.define do
  factory :user do
    username { "username" }
    password { "password" }

    sequence(:id)

    after(:create) do |user|
      user.token = JsonWebTokenService.encode(user_id: user.id)
    end
  end
end
