module Web
  module Controllers
    module Sessions
      class New
        include Web::Action

        prepend_before :skip_authentication!

        def initialize(failure_message: nil)
          @failure_message = failure_message
        end

        def call(params)
          flash[:notice] = @failure_message if @failure_message
        end
      end
    end
  end
end
