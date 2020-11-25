# frozen_string_literal: true

module Parser
  module Helpers
    class CreateLinks
      include Import[link_repo: 'repositories.link']

      def call(game_details:, release:)
        game_details['links'].each do |link_detail|
          existing_link = link_repo.find_by(url: link_detail['url'])
          next if existing_link

          create_link(link_detail, release)
        end
      end

      private

      def create_link(link_detail, release)
        link_repo.create(
          url: link_detail['url'],
          type: link_detail['type'],
          release_id: release.id
        )
      end
    end
  end
end
