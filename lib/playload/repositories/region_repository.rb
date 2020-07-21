# frozen_string_literal: true

class RegionRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :publication_regions
    has_many :publications, through: :publication_regions
  end
end
