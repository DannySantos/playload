# frozen_string_literal: true

module Web
  module Controllers
    module Users
      class New
        include Web::Action

        prepend_before :skip_authentication!

        def call(params); end
      end
    end
  end
end
