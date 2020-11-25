# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreateReleaseClassification do
  let(:result)                 { described_class.new(new_params).call(call_params) }
  let(:release_classification) { build(:release_classification) }
  let(:release)                { build(:release) }
  let(:classification)         { build(:classification) }

  let(:release_classification_repo) { instance_double ReleaseClassificationRepository }

  let(:new_params)    { Hash[release_classification_repo: release_classification_repo] }
  let(:call_params)   { Hash[release: release, classification: classification] }

  let(:release_classification_params) { Hash[release_id: release.id, classification_id: classification.id] }

  describe '#call' do
    before do
      allow(release_classification_repo).to receive(:create)
    end

    context 'when the release_classification does not exist' do
      before do
        allow(release_classification_repo).to receive(:find_by).and_return(nil)
        result
      end

      it 'tries to find the release_classification in the database' do
        expect(release_classification_repo).to have_received(:find_by).with(release_classification_params)
      end

      it 'creates only one release_classification' do
        expect(release_classification_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the release_classification' do
        expect(release_classification_repo).to have_received(:create).with(release_classification_params)
      end
    end

    context 'when the release_classification already exists' do
      before do
        allow(release_classification_repo).to receive(:find_by).and_return(release_classification)
        result
      end

      it 'tries to find the release_classification in the database' do
        expect(release_classification_repo).to have_received(:find_by).with(release_classification_params)
      end

      it 'does not create the release_classification' do
        expect(release_classification_repo).not_to have_received(:create)
      end
    end
  end
end
