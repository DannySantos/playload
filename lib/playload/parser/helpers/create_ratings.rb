# frozen_string_literal: true

module Parser
  module Helpers
    class CreateRatings
      include Import[
        rating_repo: 'repositories.rating',
        release_rating_repo: 'repositories.release_rating',
        rating_description_repo: 'repositories.rating_description',
        release_rating_description_repo: 'repositories.release_rating_description'
      ]

      def call(game_details:, release:)
        create_ratings(game_details, release)
        create_descriptions(game_details, release)
      end

      private

      def create_ratings(game_details, release)
        game_details['PEGI']['ratings'].each do |rating_name|
          existing_rating = rating_repo.find_by(name: rating_name)
          next if existing_rating

          rating = rating_repo.create(name: rating_name)
          release_rating_repo.create(release_id: release.id, rating_id: rating.id)
        end
      end

      def create_descriptions(game_details, release)
        game_details['PEGI']['descriptions'].each do |rating_description_name|
          existing_rating_description = rating_description_repo.find_by(name: rating_description_name)
          next if existing_rating_description

          rating_description = rating_description_repo.create(name: rating_description_name)
          release_rating_description_repo.create(release_id: release.id, rating_description_id: rating_description.id)
        end
      end
    end
  end
end
