# frozen_string_literal: true

class EditionRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :publication_editions
    has_many :publications, through: :publication_editions
  end
end
