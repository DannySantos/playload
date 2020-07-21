# frozen_string_literal: true

module Parser
  module Helpers
    class CreateKeyFeatures
      include Import[key_feature_repo: 'repositories.key_feature']

      def call(game_details:, publication:)
        game_details['key_features_list'].each do |key_feature_details|
          existing_key_feature = key_feature_repo.find_by(text: key_feature_details['key_features'])
          next if existing_key_feature

          create_key_feature(key_feature_details, publication)
        end
      end

      private

      def create_key_feature(key_feature_details, publication)
        key_feature_repo.create(
          publication_id: publication.id,
          text: key_feature_details['key_features'],
          type: key_feature_details['type'],
          region: key_feature_details['region'],
          std: key_feature_details['std']
        )
      end
    end
  end
end
