# frozen_string_literal: true

FactoryBot.define do
  factory :release, class: 'Release' do
    id                    { Faker::Number.number(digits: 5) }
    game_id               { game.id }
    platform_id           { platform.id }
    updated_by_gameopedia { Time.now }
    created_at            { Time.now }
    updated_at            { created_at }

    transient do
      game     { build(:game) }
      platform { build(:platform) }
    end

    initialize_with do
      new(attributes)
    end
  end
end
