class ClassificationRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :classification_category
    has_many :release_classifications
    has_many :releases, through: :release_classifications
  end
end
