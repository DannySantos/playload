# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreateReviewer
      include Import[reviewer_repo: 'repositories.reviewer']

      def call(review_details:)
        reviewer = reviewer_repo.find(review_details['reviewer_id'].to_i)
        reviewer ||= reviewer_repo.find_by(name: review_details['reviewer'])
        return reviewer if reviewer

        reviewer_repo.create(id: review_details['reviewer_id'].to_i, name: review_details['reviewer'])
      end
    end
  end
end
