class LinkRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :release
  end
end
