# frozen_string_literal: true

module Helpers
  class BuildUuid
    def call
      UUID.generate
    end
  end
end
