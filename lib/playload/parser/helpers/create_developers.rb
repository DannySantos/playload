# frozen_string_literal: true

module Parser
  module Helpers
    class CreateDevelopers
      include Import[
        developer_repo: 'repositories.developer',
        release_developer_repo: 'repositories.release_developer'
      ]

      def call(game_details:, release:)
        game_details['companies']['developers'].each do |developer_details|
          existing_developer = developer_repo.find(developer_details['id'].to_i)
          next if existing_developer

          developer = create_developer(developer_details)
          create_release_developer(release, developer)
        end
      end

      private

      def create_developer(developer_details)
        developer_repo.create(id: developer_details['id'].to_i, name: developer_details['name'])
      end

      def create_release_developer(release, developer)
        release_developer_repo.create(release_id: release.id, developer_id: developer.id)
      end
    end
  end
end
