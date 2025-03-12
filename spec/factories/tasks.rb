FactoryBot.define do
  factory :task do
    title { Faker::Name.name }
    description { Faker::Lorem.sentence(word_count: 3) }
    status { :created }
    association :project
  end
end
