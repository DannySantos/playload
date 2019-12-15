module Web
  module Controllers
    module Users
      class Create
        include Web::Action
        include Hanami::Validations

        params Web::Validations::Users::Create

        def initialize(dependencies)
          @interactor = dependencies[:interactor]
        end
        
        def call(params)
          if params.valid?
            result = @interactor.call(params: params.to_h)
            process_result(result)
          end
        end
        
        private
        
        def process_result(result)
          user = result[0]

          if user.nil?
            self.body = Web::Views::User::New.render(exposures)
          else
            redirect_to routes.root_path
          end
        end

        def dependencies
          { interactor: Interactors::Users::Create.new }
        end          
      end
    end
  end
end
