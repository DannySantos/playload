# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreateClassificationCategory do
  let(:result)                  { described_class.new(new_params).call(call_params) }
  let(:classification_category) { build(:classification_category) }

  let(:classification_category_repo) { instance_double ClassificationCategoryRepository }

  let(:new_params)  { Hash[classification_category_repo: classification_category_repo] }
  let(:call_params) { Hash[classification_category_detail: classification_category_detail] }

  let(:create_params) do
    {
      id: 1,
      name: 'Genre',
      priority: 4
    }
  end

  let(:classification_category_detail) do
    JSON.parse('{
      "id": "1",
      "name": "Genre",
      "priority": 4,
      "classifications": [{ "id": "17", "name": "Adventure" }]
    }')
  end

  describe '#call' do
    before do
      allow(classification_category_repo).to receive(:find).and_return(nil)
      allow(classification_category_repo).to receive(:create).and_return(classification_category)
      result
    end

    describe 'creating classification_categories' do
      it 'tries to find the classification_category in the database' do
        expect(classification_category_repo).to have_received(:find).with(1)
      end

      it 'creates only one classification_category' do
        expect(classification_category_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the classification_category' do
        expect(classification_category_repo).to have_received(:create).with(create_params)
      end
    end
  end
end
