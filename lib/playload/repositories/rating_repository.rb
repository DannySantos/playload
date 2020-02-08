class RatingRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :release_ratings
    has_many :releases, through: :release_ratings
  end
end
