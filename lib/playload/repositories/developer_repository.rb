# frozen_string_literal: true

class DeveloperRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :release_developers
    has_many :releases, through: :release_developers
  end
end
