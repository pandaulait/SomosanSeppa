FactoryBot.define do
  factory :selection_quiz do
    content { Faker::Lorem.characters(number: 20) }
    explanation { Faker::Lorem.characters(number: 20) }
    user
  end
end
