# frozen_string_literal: true

module Parser
  module Helpers
    class CreateGame
      include Import[game_repo: 'repositories.game']

      def call(game_details:)
        game = fetch_existing_game(game_details)
        return game if game

        game_repo.create(fetch_game_attrs(game_details))
      end

      private

      def fetch_existing_game(game_details)
        game = game_repo.find_by(title: game_details['title'])
        game ||= game_repo.find_by(us_title: game_details['us_title']) unless game_details['us_title'].nil?
        game ||= game_repo.find_by(uk_title: game_details['uk_title']) unless game_details['uk_title'].nil?
        game
      end

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
