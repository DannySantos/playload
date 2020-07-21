# frozen_string_literal: true

class ReleaseRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :game
    belongs_to :platform
    has_many :alternative_titles
    has_many :videos
    has_many :links
    has_many :screenshots
    has_many :covers
    has_many :release_ratings
    has_many :ratings, through: :release_ratings
    has_many :release_developers
    has_many :developers, through: :release_developers
    has_many :release_classifications
    has_many :classifications, through: :release_classifications
    has_many :release_tech_specs
    has_many :tech_specs, through: :release_tech_specs
    has_many :reviews
    has_many :reviewers, through: :reviews
  end
end
