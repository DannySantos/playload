# frozen_string_literal: true

FactoryBot.define do
  factory :tech_spec, class: 'TechSpec' do
    id         { Faker::Number.number(digits: 5) }
    name       { Faker::Book.genre }
    priority   { Faker::Number.number(digits: 2) }
    value      { Faker::String.random(length: [5..10]) }
    created_at { Time.now }
    updated_at { created_at }

    tech_spec_group_id { tech_spec_group.id }

    transient do
      tech_spec_group { build(:tech_spec_group) }
    end

    initialize_with do
      new(attributes)
    end
  end
end
