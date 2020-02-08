class PlatformRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :releases
  end
end
