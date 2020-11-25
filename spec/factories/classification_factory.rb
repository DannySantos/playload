# frozen_string_literal: true

FactoryBot.define do
  factory :classification, class: 'Classification' do
    id         { Faker::Number.number(digits: 5) }
    name       { Faker::Book.genre }
    priority   { Faker::Number.number(digits: 2) }
    created_at { Time.now }
    updated_at { created_at }

    classification_category_id { classification_category.id }

    transient do
      classification_category { build(:classification_category) }
    end

    initialize_with do
      new(attributes)
    end
  end
end
