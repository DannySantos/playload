class GameRatingDescriptionRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :game
    belongs_to :rating_description
  end
end
