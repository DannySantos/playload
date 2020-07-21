# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreatePublicationRegion
      include Import[publication_region_repo: 'repositories.publication_region']

      def call(publication:, region:)
        publication_region = publication_region_repo.find_by(publication_id: publication.id, region_id: region.id)
        return publication_region if publication_region

        publication_region_repo.create(publication_id: publication.id, region_id: region.id)
      end
    end
  end
end
