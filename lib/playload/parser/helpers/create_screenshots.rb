# frozen_string_literal: true

module Parser
  module Helpers
    class CreateScreenshots
      include Import[
        screenshot_repo: 'repositories.screenshot',
        build_uuid: 'helpers.build_uuid'
      ]

      def call(game_details:, release:)
        game_details['screenshots']&.each do |screenshot_detail|
          group_id = Container['helpers.build_uuid'].call
          existing_screenshot = screenshot_repo.find_by(url: screenshot_detail['original_url'])
          create_original_screenshot(screenshot_detail, release, group_id) unless existing_screenshot
          create_other_resolutions(screenshot_detail, release, group_id)
        end
      end

      private

      def create_original_screenshot(screenshot_detail, release, group_id)
        screenshot_repo.create(
          url: screenshot_detail['original_url'],
          type: 'original',
          release_id: release.id,
          group_id: group_id
        )
      end

      def create_other_resolutions(screenshot_detail, release, group_id)
        screenshot_detail['other_resolutions'].each do |resolution_detail|
          existing_resolution = screenshot_repo.find_by(url: resolution_detail['url'])
          next if existing_resolution

          create_screenshot(resolution_detail, release, group_id)
        end
      end

      def create_screenshot(screenshot_detail, release, group_id)
        screenshot_repo.create(
          url: screenshot_detail['url'],
          type: screenshot_detail['type'],
          release_id: release.id,
          group_id: group_id
        )
      end
    end
  end
end
