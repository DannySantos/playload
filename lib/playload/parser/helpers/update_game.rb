# frozen_string_literal: true

module Parser
  module Helpers
    class UpdateGame
      include Import[game_repo: 'repositories.game']

      def call(game_details:, game:)
        game_repo.update(game.id, fetch_game_attrs(game_details))
      end

      private

      def fetch_game_attrs(game_details)
        {
          title: game_details['title'],
          us_title: game_details['us_title'],
          uk_title: game_details['uk_title']
        }
      end
    end
  end
end
