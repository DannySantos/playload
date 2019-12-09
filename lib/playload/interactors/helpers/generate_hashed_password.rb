# frozen_string_literal: true

module Interactors
  module Helpers
    class GenerateHashedPassword
      MB = 1024 * 1024

      def call(password:, salt: nil)
        salt ||= generate_salt
        hashed_password = SCrypt::Engine.hash_secret(password, salt)

        {
          salt: salt,
          hashed_password: hashed_password
        }
      end

      private

      def generate_salt
        SCrypt::Engine.generate_salt(scrypt_vals)
      end

      def scrypt_vals
        if Hanami.env == 'production'
          { max_time: 1,   max_mem: 64 * MB }
        else
          { max_time: 0.1, max_mem: 16 * MB }
        end
      end
    end
  end
end
