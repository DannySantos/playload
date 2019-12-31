# frozen_string_literal: true

FactoryBot.define do
  DEFAULT_SALT = '4000$8$1$E1F53135E559C253'
  DEFAULT_HASHED_PASSWORD = '72AE25495A7981C40622D49F9A52E4F1565C90F048F59027BD9C8C8900D5C3D8'

  factory :user, class: 'User' do
    email { Faker::Internet.email }
    created_at { Time.now }
    updated_at { created_at }

    initialize_with do
      initialize_attrs = attributes.merge(hashed_password: DEFAULT_HASHED_PASSWORD, salt: DEFAULT_SALT)
      new(initialize_attrs)
    end
  end
end
