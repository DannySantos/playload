# frozen_string_literal: true

module Interactors
  module Users
    class Create
      include Import[
        user_repo: 'repositories.user',
        generate_hashed_password: 'interactors.helpers.generate_hashed_password'
      ]

      def call(params:)
        return passwords_do_not_match_result unless passwords_match?(params[:user])

        existing_user = user_repo.find_by(email: params[:user][:email])

        if existing_user
          [nil, 'Email address is already registered']
        else
          user = user_repo.create(full_params(params[:user]))
          [user, 'Successfully registered']
        end
      end

      private

      def passwords_match?(user_params)
        user_params[:password] == user_params[:password_confirmation]
      end

      def passwords_do_not_match_result
        [nil, 'Password and confirmation do not match']
      end

      def full_params(user_params)
        user_params.merge(**generate_hashed_password.call(password: user_params[:password]))
      end
    end
  end
end
