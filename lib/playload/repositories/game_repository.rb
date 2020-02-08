class GameRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :game_rating_descriptions
    has_many :rating_descriptions, through: :game_rating_descriptions
    has_many :game_engines
    has_many :engines, through: :game_engines
    has_many :releases
  end
end
