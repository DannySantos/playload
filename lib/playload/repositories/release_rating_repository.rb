# frozen_string_literal: true

class ReleaseRatingRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :release
    belongs_to :rating
  end
end
