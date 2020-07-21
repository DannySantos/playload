# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreateRegion
      include Import[region_repo: 'repositories.region']

      def call(review_details:)
        region = region_repo.find(review_details['locality_id'].to_i)
        return region if region

        region_repo.create(id: review_details['locality_id'].to_i, name: nil)
      end
    end
  end
end
