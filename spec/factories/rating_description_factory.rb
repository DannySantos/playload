# frozen_string_literal: true

FactoryBot.define do
  factory :rating_description, class: 'RatingDescription' do
    id         { Faker::Number.number(digits: 5) }
    name       { Faker::String.random(length: [0, 6]) }
    created_at { Time.now }
    updated_at { created_at }

    initialize_with do
      new(attributes)
    end
  end
end
