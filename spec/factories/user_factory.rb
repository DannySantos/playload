# frozen_string_literal: true

FactoryBot.define do
  DEFAULT_USER_SALT = '4000$8$1$E1F53135E559C253'
  DEFAULT_USER_HASHED_PASSWORD = '72AE25495A7981C40622D49F9A52E4F1565C90F048F59027BD9C8C8900D5C3D8'

  factory :user, class: 'User' do
    email      { Faker::Internet.email }
    created_at { Time.now }
    updated_at { created_at }
    password   { DEFAULT_USER_HASHED_PASSWORD }

    initialize_with do
      if password == DEFAULT_USER_HASHED_PASSWORD
        new(attributes.merge(hashed_password: DEFAULT_USER_HASHED_PASSWORD, salt: DEFAULT_USER_SALT))
      else
        password_hash = Interactors::Helpers::GenerateHashedPassword.new.call(password: password)
        new(attributes.merge(hashed_password: password_hash[:hashed_password], salt: password_hash[:salt]))
      end
    end
  end
end
