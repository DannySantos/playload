# frozen_string_literal: true

module Parser
  module Helpers
    class CreatePublishers
      include Import[
        publisher_repo: 'repositories.publisher',
        publication_publisher_repo: 'repositories.publication_publisher'
      ]

      def call(game_details:, publication:)
        game_details['companies']['publishers']&.each do |publisher_details|
          existing_publisher = publisher_repo.find(publisher_details['id'].to_i)
          existing_publisher ||= publisher_repo.find_by(name: publisher_details['name'])
          next if existing_publisher

          publisher = create_publisher(publisher_details)
          create_publication_publisher(publication, publisher)
        end
      end

      private

      def create_publisher(publisher_details)
        publisher_repo.create(id: publisher_details['id'].to_i, name: publisher_details['name'])
      end

      def create_publication_publisher(publication, publisher)
        publication_publisher_repo.create(publication_id: publication.id, publisher_id: publisher.id)
      end
    end
  end
end
