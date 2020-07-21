# frozen_string_literal: true

class ClassificationCategoryRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :classifications
  end
end
