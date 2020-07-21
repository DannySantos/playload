# frozen_string_literal: true

FactoryBot.define do
  factory :region, class: 'Region' do
    id         { Faker::Number.number(digits: 5) }
    name       { Faker::Address.country }
    created_at { Time.now }
    updated_at { created_at }

    initialize_with do
      new(attributes)
    end
  end
end
