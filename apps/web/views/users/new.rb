module Web
  module Views
    module Users
      class New
        include Web::View

        def user_new_form
          form_for :user, routes.users_path do
            label :email
            email_field :email
            label :password
            password_field :password
            label :password_confirmation
            password_field :password_confirmation
            submit 'Register'
          end
        end
      end
    end
  end
end
