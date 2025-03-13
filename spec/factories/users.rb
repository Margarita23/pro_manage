FactoryBot.define do
  password = Faker::Internet.password(min_length: 6)

  factory :user do
    email { Faker::Internet.unique.email }
    password { password }
    password_confirmation { password }
  end
end
