# frozen_string_literal: true

class GameRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :release_rating_descriptions
    has_many :rating_descriptions, through: :release_rating_descriptions
    has_many :game_engines
    has_many :engines, through: :game_engines
    has_many :releases
  end
end
