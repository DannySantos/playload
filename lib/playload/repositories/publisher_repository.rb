# frozen_string_literal: true

class PublisherRepository < Hanami::Repository
  include ::BaseRepository

  associations do
    has_many :publication_publishers
    has_many :publications, through: :publication_publishers
  end
end
