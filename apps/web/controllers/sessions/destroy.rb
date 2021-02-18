module Web
  module Controllers
    module Sessions
      class Destroy
        include Web::Action

        prepend_before :skip_authentication!

        def call(_params)
          process
        end
        
        private
        
        def process
          warden.logout
          flash[:notice] = 'Successfully logged out'
          redirect_to routes.root_path
        end
      end
    end
  end
end
