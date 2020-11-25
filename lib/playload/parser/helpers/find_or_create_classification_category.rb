# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreateClassificationCategory
      include Import[classification_category_repo: 'repositories.classification_category']

      def call(classification_category_detail:)
        classification_category_id = classification_category_detail['id'].to_i
        existing_classification_category = classification_category_repo.find(classification_category_id)
        return existing_classification_category if existing_classification_category

        create_classification_category(classification_category_detail)
      end

      private

      def create_classification_category(classification_category_detail)
        classification_category_repo.create(
          id: classification_category_detail['id'].to_i,
          name: classification_category_detail['name'],
          priority: classification_category_detail['priority']
        )
      end
    end
  end
end
