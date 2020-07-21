# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreateReleaseTechSpec do
  let(:result)            { described_class.new(new_params).call(call_params) }
  let(:release_tech_spec) { build(:release_tech_spec) }
  let(:release)           { build(:release) }
  let(:tech_spec)         { build(:tech_spec) }

  let(:release_tech_spec_repo) { instance_double ReleaseTechSpecRepository }

  let(:new_params)  { Hash[release_tech_spec_repo: release_tech_spec_repo] }
  let(:call_params) { Hash[release: release, tech_spec: tech_spec] }

  let(:release_tech_spec_params) { Hash[release_id: release.id, tech_spec_id: tech_spec.id] }

  describe '#call' do
    before do
      allow(release_tech_spec_repo).to receive(:create)
    end

    context 'when the release_tech_spec does not exist' do
      before do
        allow(release_tech_spec_repo).to receive(:find_by).and_return(nil)
        result
      end

      it 'tries to find the release_tech_spec in the database' do
        expect(release_tech_spec_repo).to have_received(:find_by).with(release_tech_spec_params)
      end

      it 'creates only one release_tech_spec' do
        expect(release_tech_spec_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the release_tech_spec' do
        expect(release_tech_spec_repo).to have_received(:create).with(release_tech_spec_params)
      end
    end

    context 'when the release_tech_spec already exists' do
      before do
        allow(release_tech_spec_repo).to receive(:find_by).and_return(release_tech_spec)
        result
      end

      it 'tries to find the release_tech_spec in the database' do
        expect(release_tech_spec_repo).to have_received(:find_by).with(release_tech_spec_params)
      end

      it 'does not create the release_tech_spec' do
        expect(release_tech_spec_repo).not_to have_received(:create)
      end
    end
  end
end
