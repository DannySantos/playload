# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreatePublication
      include Import[publication_repo: 'repositories.publication']

      def call(game_details:, release:)
        publication = publication_repo.find_by(title: game_details['title'])
        return publication if publication

        publication_repo.create(fetch_publication_attrs(game_details, release))
      end

      private

      def fetch_publication_attrs(game_details, release)
        {
          title: game_details['title'],
          gameopedia_id: game_details['public_id'],
          release_id: release.id,
          barcode: game_details['barcode'],
          gameopedia_release_date: game_details['release_date'],
          release_date: fetch_release_date(game_details),
          distribution: game_details['distribution']
        }
      end

      def fetch_release_date(game_details)
        release_date = game_details['release_date']
        return nil if release_date.count('a-zA-Z').positive?

        Time.parse(game_details['release_date'])
      end
    end
  end
end
