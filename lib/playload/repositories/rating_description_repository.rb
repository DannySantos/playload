class RatingDescriptionRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :game_rating_descriptions
    has_many :games, through: :game_rating_descriptions
  end
end
