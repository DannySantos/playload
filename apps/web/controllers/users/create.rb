# frozen_string_literal: true

module Web
  module Controllers
    module Users
      class Create
        include Web::Action
        include Hanami::Validations
        include Import[interactor: 'interactors.users.create']

        params Web::Validations::Users::Create

        def call(params)
          if params.valid?
            result = interactor.call(params: params.to_h)
            process_result(result)
          else
            handle_failure(params.error_messages)
          end
        end

        private

        def process_result(result)
          user = result[0]
          message = result[1]

          if user.nil?
            handle_failure([message])
          else
            flash[:notice] = message
            redirect_to routes.root_path
          end
        end

        def handle_failure(error_messages)
          flash[:errors] = error_messages
          self.body = Web::Views::Users::New.render(exposures)
        end
      end
    end
  end
end
