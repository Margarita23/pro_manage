FactoryBot.define do
  factory :project do
    title { Faker::Name.name }
		description { Faker::Lorem.sentence(word_count: 3) }
	end
end
