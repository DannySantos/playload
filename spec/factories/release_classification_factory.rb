# frozen_string_literal: true

FactoryBot.define do
  factory :release_classification, class: 'ReleaseClassification' do
    id         { Faker::Number.number(digits: 5) }
    created_at { Time.now }
    updated_at { created_at }

    release_id        { release.id }
    classification_id { classification.id }

    transient do
      release        { build(:release) }
      classification { build(:classification) }
    end

    initialize_with do
      new(attributes)
    end
  end
end
