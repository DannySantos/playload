class ReviewerRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :reviews
    has_many :releases, through: :reviews
  end
end
