# frozen_string_literal: true

class ReleaseTechSpecRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    belongs_to :release
    belongs_to :tech_spec
  end
end
