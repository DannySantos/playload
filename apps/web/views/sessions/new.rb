# frozen_string_literal: true

module Web
  module Views
    module Sessions
      class New
        include Web::View

        def log_in_form
          form_for :session, routes.sessions_path do
            label :email
            email_field :email
            label :password
            password_field :password
            submit 'Log in'
          end
        end
      end
    end
  end
end
