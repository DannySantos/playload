# frozen_string_literal: true

module Parser
  module Helpers
    class CreateReviews
      include Import[
        review_repo: 'repositories.review',
        find_or_create_reviewer: 'parser.helpers.find_or_create_reviewer',
        find_or_create_region: 'parser.helpers.find_or_create_region'
      ]

      def call(game_details:, release:)
        game_details['reviews']&.each do |review_details|
          reviewer = find_or_create_reviewer.call(review_details: review_details)
          region = find_or_create_region.call(review_details: review_details)

          existing_review = review_repo.find_by(release_id: release.id, reviewer_id: reviewer.id, region_id: region.id)
          next if existing_review

          review_repo.create(fetch_review_attrs(review_details, reviewer, region, release))
        end
      end

      private

      def fetch_review_attrs(review_details, reviewer, region, release)
        {
          release_id: release.id,
          reviewer_id: reviewer.id,
          region_id: region.id,
          rating: review_details['rating'],
          link: review_details['link']
        }
      end
    end
  end
end
