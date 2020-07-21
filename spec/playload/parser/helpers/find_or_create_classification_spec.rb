# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreateClassification do
  let(:result)                  { described_class.new(new_params).call(call_params) }
  let(:classification)          { build(:classification) }
  let(:classification_category) { build(:classification_category) }

  let(:classification_repo) { instance_double ClassificationRepository }

  let(:new_params)    { Hash[classification_repo: classification_repo] }
  let(:create_params) { Hash[id: 17, name: 'Adventure', classification_category_id: classification_category.id] }

  let(:call_params) do
    {
      classification_detail: classification_detail,
      classification_category: classification_category
    }
  end

  let(:classification_detail) { JSON.parse('{"id": "17", "name": "Adventure"}') }

  describe '#call' do
    before do
      allow(classification_repo).to receive(:create).and_return(classification)
    end

    context 'when the classification does not exist' do
      before do
        allow(classification_repo).to receive(:find).and_return(nil)
        result
      end

      it 'tries to find the classification in the database' do
        expect(classification_repo).to have_received(:find).with(17)
      end

      it 'creates only one classification' do
        expect(classification_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the classification' do
        expect(classification_repo).to have_received(:create).with(create_params)
      end
    end

    context 'when the classification already exists' do
      before do
        allow(classification_repo).to receive(:find).and_return(classification)
        result
      end

      it 'tries to find the classification in the database' do
        expect(classification_repo).to have_received(:find).with(17)
      end

      it 'does not create the classification' do
        expect(classification_repo).not_to have_received(:create)
      end
    end
  end
end
