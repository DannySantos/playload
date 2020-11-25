# frozen_string_literal: true

class KeyFeatureRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :publication
  end
end
