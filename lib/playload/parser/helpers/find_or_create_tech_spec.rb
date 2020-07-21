# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreateTechSpec
      include Import[tech_spec_repo: 'repositories.tech_spec']

      def call(tech_spec_detail:, tech_spec_group:)
        tech_spec_id = tech_spec_detail['id'].to_i
        existing_tech_spec = tech_spec_repo.find(tech_spec_id)
        return existing_tech_spec if existing_tech_spec

        create_tech_spec(tech_spec_detail, tech_spec_group)
      end

      private

      def create_tech_spec(tech_spec_detail, tech_spec_group)
        tech_spec_repo.create(
          id: tech_spec_detail['id'].to_i,
          name: tech_spec_detail['name'],
          value: tech_spec_detail['value'],
          priority: tech_spec_detail['priority'],
          tech_spec_group_id: tech_spec_group.id
        )
      end
    end
  end
end
