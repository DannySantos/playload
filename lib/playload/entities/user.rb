# frozen_string_literal: true

class User < Hanami::Entity
  def password_match?(password)
    ::SCrypt::Engine.hash_secret(password, salt) == hashed_password
  end
end
