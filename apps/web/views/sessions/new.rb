# frozen_string_literal: true

module Web
  module Views
    module Sessions
      class New
        include Web::View

        def log_in_form
          form_for :session, routes.sessions_path do
            div class: 'col-1-1 mb10' do
              label :email
              email_field :email, class: 'w100p'
            end

            div class: 'col-1-1 mb10' do
              label :password
              password_field :password, class: 'w100p'
            end

            div class: 'col-1-1 mb10 tac' do
              submit 'Log in'
            end
          end
        end
      end
    end
  end
end
