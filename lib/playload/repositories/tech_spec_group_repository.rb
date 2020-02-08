class TechSpecGroupRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :tech_specs
    has_many :release_tech_specs, through: :tech_specs
  end
end
