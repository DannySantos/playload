# frozen_string_literal: true

module Parser
  module Helpers
    class UpdateRelease
      include Import[release_repo: 'repositories.release']

      def call(game_details:, game:, platform:, release:)
        release_repo.update(release.id, fetch_release_attrs(game_details, game, platform))
      end

      private

      def fetch_release_attrs(game_details, game, platform)
        {
          updated_by_gameopedia: Time.parse(game_details['updated']),
          game_id: game.id,
          platform_id: platform.id
        }
      end
    end
  end
end
