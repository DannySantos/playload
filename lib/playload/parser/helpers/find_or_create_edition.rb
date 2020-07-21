# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreateEdition
      include Import[
        edition_repo: 'repositories.edition',
        publication_edition_repo: 'repositories.publication_edition'
      ]

      def call(game_details:, publication:)
        existing_edition = edition_repo.find(game_details['edition']['id'].to_i)
        return existing_edition if existing_edition

        edition = create_edition(game_details)
        publication_edition_repo.create(publication_id: publication.id, edition_id: edition.id)
      end

      private

      def create_edition(game_details)
        edition_repo.create(id: game_details['edition']['id'].to_i, name: game_details['edition']['name'])
      end
    end
  end
end
