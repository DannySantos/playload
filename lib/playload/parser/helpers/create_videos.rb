# frozen_string_literal: true

module Parser
  module Helpers
    class CreateVideos
      include Import[video_repo: 'repositories.video']

      def call(game_details:, release:)
        game_details['videos']&.each do |video_detail|
          existing_video = video_repo.find_by(url: video_detail['url'])
          next if existing_video

          create_video(video_detail, release)
        end
      end

      private

      def create_video(video_detail, release)
        video_repo.create(
          url: video_detail['url'],
          embed_url: video_detail['embed_url'],
          info: video_detail['info'],
          release_id: release.id
        )
      end
    end
  end
end
