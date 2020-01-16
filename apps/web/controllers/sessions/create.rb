# frozen_string_literal: true

module Web
  module Controllers
    module Sessions
      class Create
        include Web::Action

        prepend_before :skip_authentication!

        params Web::Validations::Sessions::Create

        def call(params)
          if params.valid?
            process
          else
            handle_failure(params.error_messages)
          end
        end

        private

        def process
          warden.authenticate!(:password)
          flash[:notice] = 'Successfully logged in'
          redirect_to routes.root_path
        end

        def handle_failure(error_messages)
          flash[:errors] = error_messages
          redirect_to routes.new_session_path
        end
      end
    end
  end
end
