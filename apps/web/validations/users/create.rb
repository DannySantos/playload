# frozen_string_literal: true

require 'hanami/validations'
# require_relative '../common_predicates'

module Web
  module Validations
    module Users
      class Create < Web::Action::Params
        predicates Web::Validations::CommonPredicates

        validations do
          required(:user).schema do
            required(:email, :string).filled(:str?, :email?, :safe_string?)
            required(:password, :string).filled(:str?, :valid_password?)
            required(:password_confirmation, :string).filled(:str?)
          end
        end
      end
    end
  end
end
