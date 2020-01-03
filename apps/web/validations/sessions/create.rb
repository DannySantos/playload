# frozen_string_literal: true

require 'hanami/validations'

module Web
  module Validations
    module Sessions
      class Create < Web::Action::Params
        predicates Web::Validations::CommonPredicates

        validations do
          required(:session).schema do
            required(:email, :string).filled(:str?, :email?, :safe_string?)
            required(:password, :string).filled(:str?, :valid_password?)
          end
        end
      end
    end
  end
end
