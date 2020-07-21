# frozen_string_literal: true

class ReleaseDeveloperRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :release
    belongs_to :developer
  end
end
