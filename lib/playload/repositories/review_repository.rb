class ReviewRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :release
    belongs_to :region
    belongs_to :reviewer
  end
end
