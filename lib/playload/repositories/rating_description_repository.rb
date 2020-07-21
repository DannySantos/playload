# frozen_string_literal: true

class RatingDescriptionRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :release_rating_descriptions
    has_many :games, through: :release_rating_descriptions
  end
end
