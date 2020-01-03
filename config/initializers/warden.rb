# frozen_string_literal: true

Warden::Strategies.add(:password) do
  def valid?
    params['session']['email'] && params['session']['password']
  end

  def authenticate!
    user = UserRepository.new.find_by(email: params['session']['email'])
    return fail!('User does not exist') unless user
    return fail!('Login details were incorrect') unless user.password_match?(params['session']['password'])

    success!(user)
  end
end
