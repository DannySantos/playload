# frozen_string_literal: true

module Parser
  module Helpers
    class FindOrCreateReleaseTechSpec
      include Import[release_tech_spec_repo: 'repositories.release_tech_spec']

      def call(release:, tech_spec:)
        release_tech_spec_params = { release_id: release.id, tech_spec_id: tech_spec.id }
        existing_release_tech_spec = release_tech_spec_repo.find_by(release_tech_spec_params)
        return existing_release_tech_spec if existing_release_tech_spec

        release_tech_spec_repo.create(release_tech_spec_params)
      end
    end
  end
end
