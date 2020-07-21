# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreateRelease
      include Import[release_repo: 'repositories.release']

      def call(game_details:, game:, platform:)
        release = release_repo.find(game_details['release_id'])
        return release if release

        release_repo.create(fetch_release_attrs(game_details, game, platform))
      end

      private

      def fetch_release_attrs(game_details, game, platform)
        {
          id: game_details['release_id'],
          updated_by_gameopedia: Time.parse(game_details['updated']),
          game_id: game.id,
          platform_id: platform.id
        }
      end
    end
  end
end
