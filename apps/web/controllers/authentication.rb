# frozen_string_literal: true

module Web
  module Controllers
    module Authentication
      def self.included(action)
        action.class_eval do
          expose :current_user
          before :authenticate!
        end
      end

      def current_user
        @current_user ||= warden&.user
      end

      private

      def warden
        params.env['warden']
      end

      def authenticate!
        return if @skip_authentication

        authenticate_current_user!

        return if @skip_signing_address_authentication

        authenticate_signing_address!
      end

      def authenticate_current_user!
        return if current_user

        flash[:notice] = 'User authentication issue, please login again'
        redirect_to routes.new_session_path
      end

      def skip_authentication!
        @skip_authentication ||= true
      end
    end
  end
end
