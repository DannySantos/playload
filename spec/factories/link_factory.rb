# frozen_string_literal: true

FactoryBot.define do
  factory :link, class: 'Link' do
    id         { Faker::Number.number(digits: 5) }
    url        { Faker::Internet.url }
    type       { %w[Facebook Twitter YouTube Website].sample }
    release_id { release.id }
    created_at { Time.now }
    updated_at { created_at }

    transient do
      release { build(:release) }
    end

    initialize_with do
      new(attributes)
    end
  end
end
