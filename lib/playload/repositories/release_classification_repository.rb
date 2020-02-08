class ReleaseClassificationRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :release
    belongs_to :classification
  end
end
