# frozen_string_literal: true

module Parser
  module Helpers
    class CreateAlternativeTitles
      include Import[alternative_title_repo: 'repositories.alternative_title']

      def call(game_details:, release:)
        game_details['alternative_titles']&.each do |alternative_title|
          existing_alternative_title = alternative_title_repo.find_by(title: alternative_title)
          next if existing_alternative_title

          alternative_title_repo.create(title: alternative_title, release_id: release.id)
        end
      end
    end
  end
end
