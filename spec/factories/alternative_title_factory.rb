# frozen_string_literal: true

FactoryBot.define do
  factory :alternative_title, class: 'AlternativeTitle' do
    id         { Faker::Number.number(digits: 5) }
    title      { Faker::Game.title }
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
