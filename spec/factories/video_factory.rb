# frozen_string_literal: true

FactoryBot.define do
  factory :video, class: 'Video' do
    id         { Faker::Number.number(digits: 5) }
    url        { Faker::Internet.url }
    embed_url  { Faker::Internet.url }
    info       { Faker::String.random(length: [0, 20]) }
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
