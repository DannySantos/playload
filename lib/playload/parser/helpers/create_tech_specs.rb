# frozen_string_literal: true

module Parser
  module Helpers
    class CreateTechSpecs
      include Import[
        find_or_create_tech_spec_group: 'parser.helpers.find_or_create_tech_spec_group',
        find_or_create_tech_spec: 'parser.helpers.find_or_create_tech_spec',
        find_or_create_release_tech_spec: 'parser.helpers.find_or_create_release_tech_spec'
      ]

      def call(game_details:, release:)
        tech_specs = game_details['technical_specifications'] || []

        tech_specs&.each do |tech_spec_group_detail|
          tech_spec_group_params = { tech_spec_group_detail: tech_spec_group_detail }
          tech_spec_group = find_or_create_tech_spec_group.call(tech_spec_group_params)

          tech_spec_group_detail['tech_specs']&.each do |tech_spec_detail|
            tech_spec_params = { tech_spec_detail: tech_spec_detail, tech_spec_group: tech_spec_group }
            tech_spec = find_or_create_tech_spec.call(tech_spec_params)
            find_or_create_release_tech_spec.call(release: release, tech_spec: tech_spec)
          end
        end
      end
    end
  end
end
