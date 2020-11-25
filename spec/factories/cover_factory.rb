# frozen_string_literal: true

FactoryBot.define do
  factory :cover, class: 'Cover' do
    id         { Faker::Number.number(digits: 5) }
    url        { Faker::Internet.url }
    type       { Faker::String.random(length: [0..8]) }
    group_id   { Container['helpers.build_uuid'].call }
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
