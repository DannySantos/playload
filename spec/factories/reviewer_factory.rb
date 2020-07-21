# frozen_string_literal: true

FactoryBot.define do
  factory :reviewer, class: 'Reviewer' do
    id         { Faker::Number.number(digits: 5) }
    name       { Faker::Company.name }
    created_at { Time.now }
    updated_at { created_at }

    initialize_with do
      new(attributes)
    end
  end
end
