# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreateTechSpecGroup
      include Import[tech_spec_group_repo: 'repositories.tech_spec_group']

      def call(tech_spec_group_detail:)
        tech_spec_group_id = tech_spec_group_detail['id'].to_i
        existing_tech_spec_group = tech_spec_group_repo.find(tech_spec_group_id)
        return existing_tech_spec_group if existing_tech_spec_group

        create_tech_spec_group(tech_spec_group_detail)
      end

      private

      def create_tech_spec_group(tech_spec_group_detail)
        tech_spec_group_repo.create(
          id: tech_spec_group_detail['id'].to_i,
          name: tech_spec_group_detail['name'],
          priority: tech_spec_group_detail['priority']
        )
      end
    end
  end
end
