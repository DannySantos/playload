# frozen_string_literal: true

FactoryBot.define do
  factory :publication, class: 'Publication' do
    id            { Faker::Number.number(digits: 5) }
    title         { Faker::Game.title }
    gameopedia_id { Faker::Number.number(digits: 5) }
    release_id    { Faker::Number.number(digits: 5) }
    barcode       { Faker::String.random(length: [0, 6]) }
    release_date  { Time.now }
    distribution  { Faker::String.random(length: [0, 20]) }
    created_at    { Time.now }
    updated_at    { created_at }

    transient do
      game     { build(:game) }
      platform { build(:platform) }
    end

    initialize_with do
      new(attributes)
    end
  end
end
