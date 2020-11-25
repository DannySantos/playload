# frozen_string_literal: true

FactoryBot.define do
  factory :game, class: 'Game' do
    id         { Faker::Number.number(digits: 5) }
    title      { Faker::Game.title }
    us_title   { Faker::Game.title }
    uk_title   { Faker::Game.title }
    created_at { Time.now }
    updated_at { created_at }

    initialize_with do
      new(attributes)
    end
  end
end
