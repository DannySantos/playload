# frozen_string_literal: true

module Parser
  module Helpers
    class CreateClassifications
      include Import[
        find_or_create_classification_category: 'parser.helpers.find_or_create_classification_category',
        find_or_create_classification: 'parser.helpers.find_or_create_classification',
        find_or_create_release_classification: 'parser.helpers.find_or_create_release_classification'
      ]

      def call(game_details:, release:)
        game_details['classifications']&.each do |classification_category_detail|
          classification_category_params = { classification_category_detail: classification_category_detail }
          classification_category = find_or_create_classification_category.call(classification_category_params)

          classification_category_detail['classifications']&.each do |classification_detail|
            handle_classification(classification_detail, classification_category, release)
          end
        end
      end

      private

      def handle_classification(classification_detail, classification_category, release)
        classification_params = {
          classification_detail: classification_detail,
          classification_category: classification_category
        }

        classification = find_or_create_classification.call(classification_params)
        find_or_create_release_classification.call(release: release, classification: classification)
      end
    end
  end
end
