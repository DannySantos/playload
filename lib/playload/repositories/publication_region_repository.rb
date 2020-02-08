class PublicationRegionRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :publication
    belongs_to :region
  end
end
