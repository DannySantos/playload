# frozen_string_literal: true

FactoryBot.define do
  factory :release_tech_spec, class: 'ReleaseTechSpec' do
    id         { Faker::Number.number(digits: 5) }
    created_at { Time.now }
    updated_at { created_at }

    release_id   { release.id }
    tech_spec_id { tech_spec.id }

    transient do
      release   { build(:release) }
      tech_spec { build(:tech_spec) }
    end

    initialize_with do
      new(attributes)
    end
  end
end
