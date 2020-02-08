class PublicationRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :release
    has_many :publication_publishers
    has_many :publishers, through: :publication_publishers
    has_many :publication_regions
    has_many :regions, through: :publication_regions
    has_many :publication_editions
    has_many :editions, through: :publication_editions
    has_many :descriptions
    has_many :key_features
  end
end
