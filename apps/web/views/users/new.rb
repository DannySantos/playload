# frozen_string_literal: true

module Web
  module Views
    module Users
      class New
        include Web::View

        def user_new_form
          form_for :user, routes.users_path do
            div class: 'col-1-1 mb10' do
              label :email
              email_field :email, class: 'w100p'
            end

            div class: 'col-1-1 mb10' do
              label :password
              password_field :password, class: 'w100p'
            end

            div class: 'col-1-1 mb10' do
              label :password_confirmation
              password_field :password_confirmation, class: 'w100p'
            end

            div class: 'col-1-1 mb10 tac' do
              submit 'Register'
            end
          end
        end
      end
    end
  end
end
