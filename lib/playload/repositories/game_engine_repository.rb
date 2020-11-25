# frozen_string_literal: true

class GameEngineRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :game
    belongs_to :engine
  end
end
