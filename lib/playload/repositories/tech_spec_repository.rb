# frozen_string_literal: true

class TechSpecRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :tech_spec_group
    has_many :release_tech_specs
  end
end
