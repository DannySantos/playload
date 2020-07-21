# frozen_string_literal: true

module Parser
  module Helpers
    class CreateRegions
      include Import[
        region_repo: 'repositories.region',
        find_or_create_publication_region: 'parser.helpers.find_or_create_publication_region'
      ]

      def call(game_details:, publication:)
        existing_region = region_repo.find(game_details['region']['id'].to_i)
        return if existing_region&.name

        if existing_region && existing_region.name.nil?
          update_region(existing_region, game_details, publication)
          return
        end

        region = create_region(game_details)
        find_or_create_publication_region.call(publication: publication, region: region)
      end

      private

      def update_region(existing_region, game_details, publication)
        updated_region = region_repo.update(existing_region.id, name: game_details['region']['name'])
        find_or_create_publication_region.call(publication: publication, region: updated_region)
      end

      def create_region(game_details)
        region_repo.create(id: game_details['region']['id'].to_i, name: game_details['region']['name'])
      end
    end
  end
end
