# frozen_string_literal: true

FactoryBot.define do
  factory :description, class: 'Description' do
    id             { Faker::Number.number(digits: 5) }
    content        { Faker::Company.catch_phrase }
    type           { Faker::String.random(length: [0, 6]) }
    region         { Faker::Nation.nationality }
    std            { true }
    publication_id { publication.id }
    created_at     { Time.now }
    updated_at     { created_at }

    transient do
      publication { build(:publication) }
    end

    initialize_with do
      new(attributes)
    end
  end
end
