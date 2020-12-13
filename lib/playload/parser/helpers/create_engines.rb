# frozen_string_literal: true

module Parser
  module Helpers
    class CreateEngines
      include Import[
        engine_repo: 'repositories.engine',
        game_engine_repo: 'repositories.game_engine'
      ]

      def call(game_details:, game:)
        game_details['game_engines']&.each do |engine|
          existing_engine = engine_repo.find_by(name: engine)
          next if existing_engine

          engine = engine_repo.create(name: engine)
          game_engine_repo.create(game_id: game.id, engine_id: engine.id)
        end
      end
    end
  end
end
