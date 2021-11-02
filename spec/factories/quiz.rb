# frozen_string_literal: true

FactoryBot.define do
  factory :quiz do
    content { Faker::Lorem.characters(number: 20) }
    explanation { Faker::Lorem.characters(number: 20) }
    user
  end
end
