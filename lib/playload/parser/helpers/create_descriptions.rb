# frozen_string_literal: true

module Parser
  module Helpers
    class CreateDescriptions
      include Import[description_repo: 'repositories.description']

      def call(game_details:, publication:)
        game_details['game_descriptions']&.each do |description_details|
          existing_description = description_repo.find_by(content: description_details['game_description'])
          next if existing_description

          create_description(description_details, publication)
        end
      end

      private

      def create_description(description_details, publication)
        description_repo.create(
          publication_id: publication.id,
          content: description_details['game_description'],
          type: description_details['type'],
          region: description_details['region'],
          std: description_details['std']
        )
      end
    end
  end
end
