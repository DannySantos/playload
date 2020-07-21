# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreateClassification
      include Import[classification_repo: 'repositories.classification']

      def call(classification_detail:, classification_category:)
        classification_id = classification_detail['id'].to_i
        existing_classification = classification_repo.find(classification_id)
        return existing_classification if existing_classification

        create_classification(classification_detail, classification_category)
      end

      private

      def create_classification(classification_detail, classification_category)
        classification_repo.create(
          id: classification_detail['id'].to_i,
          name: classification_detail['name'],
          classification_category_id: classification_category.id
        )
      end
    end
  end
end
