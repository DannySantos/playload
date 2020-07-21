# frozen_string_literal: true

FactoryBot.define do
  factory :publication_region, class: 'PublicationRegion' do
    id             { Faker::Number.number(digits: 5) }
    publication_id { publication.id }
    region_id      { region.id }
    created_at     { Time.now }
    updated_at     { created_at }

    transient do
      publication { build(:publication) }
      region      { build(:region) }
    end

    initialize_with do
      new(attributes)
    end
  end
end
