# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreateReleaseClassification
      include Import[release_classification_repo: 'repositories.release_classification']

      def call(release:, classification:)
        release_classification_params = { release_id: release.id, classification_id: classification.id }
        existing_release_classification = release_classification_repo.find_by(release_classification_params)
        return existing_release_classification if existing_release_classification

        release_classification_repo.create(release_classification_params)
      end
    end
  end
end
