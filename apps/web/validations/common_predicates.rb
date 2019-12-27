# frozen_string_literal: true

require 'hanami/validations'

module Web
  module Validations
    module CommonPredicates
      include Hanami::Validations::Predicates

      self.messages_path = "#{Hanami.root}/apps/web/config/dry_validation.yml"

      STRING_VALIDATION = /^$|^[^(\+|=|\-|@)]/.freeze
      EMAIL_VALIDATION = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
      PASSWORD_VALIDATION = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[\W]).+$/.freeze

      predicate(:safe_string?) do |value|
        !STRING_VALIDATION.match(value).nil?
      end

      predicate(:email?) do |value|
        !EMAIL_VALIDATION.match(value).nil?
      end

      predicate(:valid_password?) do |value|
        !value[PASSWORD_VALIDATION].nil?
      end
    end
  end
end
