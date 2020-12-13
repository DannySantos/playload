# frozen_string_literal: true

module Parser
  module Helpers
    class CreateCovers
      include Import[
        cover_repo: 'repositories.cover',
        build_uuid: 'helpers.build_uuid'
      ]

      def call(game_details:, release:)
        group_id = Container['helpers.build_uuid'].call
        cover_detail = game_details['cover']

        return unless cover_detail && cover_detail.any?

        existing_cover = cover_repo.find_by(url: cover_detail['original_url'])
        create_original_cover(cover_detail, release, group_id) unless existing_cover
        create_other_resolutions(cover_detail, release, group_id)
      end

      private

      def create_original_cover(cover_detail, release, group_id)
        cover_repo.create(
          url: cover_detail['original_url'],
          type: 'original',
          release_id: release.id,
          group_id: group_id
        )
      end

      def create_other_resolutions(cover_detail, release, group_id)
        cover_detail['other_resolutions']&.each do |resolution_detail|
          existing_resolution = cover_repo.find_by(url: resolution_detail['url'])
          next if existing_resolution

          create_cover(resolution_detail, release, group_id)
        end
      end

      def create_cover(cover_detail, release, group_id)
        cover_repo.create(
          url: cover_detail['url'],
          type: cover_detail['type'],
          release_id: release.id,
          group_id: group_id
        )
      end
    end
  end
end
