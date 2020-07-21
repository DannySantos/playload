# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreatePlatform
      include Import[platform_repo: 'repositories.platform']

      def call(game_details:)
        platform = platform_repo.find(game_details['platform']['id'])
        return platform if platform

        platform_repo.create(id: game_details['platform']['id'], name: game_details['platform']['name'])
      end
    end
  end
end
