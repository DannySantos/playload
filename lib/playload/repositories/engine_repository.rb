# frozen_string_literal: true

class EngineRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :game_engines
    has_many :games, through: :game_engines
  end
end
