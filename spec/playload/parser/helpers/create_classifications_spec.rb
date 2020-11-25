# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateClassifications do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:release)                 { build(:release) }
  let(:classification_category) { build(:classification_category) }
  let(:classification)          { build(:classification) }

  let(:find_or_create_classification_category) { instance_double Parser::Helpers::FindOrCreateClassificationCategory }
  let(:find_or_create_classification)          { instance_double Parser::Helpers::FindOrCreateClassification }
  let(:find_or_create_release_classification)  { instance_double Parser::Helpers::FindOrCreateReleaseClassification }

  let(:call_params) { Hash[game_details: game_details, release: release] }

  let(:classification_params) do
    lambda do |classification_detail|
      {
        classification_detail: classification_detail,
        classification_category: classification_category
      }
    end
  end

  let(:new_params) do
    {
      find_or_create_classification_category: find_or_create_classification_category,
      find_or_create_classification: find_or_create_classification,
      find_or_create_release_classification: find_or_create_release_classification
    }
  end

  describe '#call' do
    before do
      allow(find_or_create_classification_category).to receive(:call).and_return(classification_category)
      allow(find_or_create_classification).to receive(:call).and_return(classification)
      allow(find_or_create_release_classification).to receive(:call)
      result
    end

    it 'finds or creates all of the classification categories' do
      expect(find_or_create_classification_category).to have_received(:call).exactly(6).times
    end

    it 'finds or creates the classification categories' do
      game_details['classifications'].each do |classification_category_detail|
        expect(find_or_create_classification_category).to have_received(:call)
          .with(classification_category_detail: classification_category_detail)
      end
    end

    it 'finds or creates all of the classifications' do
      expect(find_or_create_classification).to have_received(:call).exactly(9).times
    end

    it 'finds or creates the classifications' do
      game_details['classifications'].each do |classification_category_detail|
        classification_category_detail['classifications'].each do |classification|
          expect(find_or_create_classification).to have_received(:call).with(classification_params[classification])
        end
      end
    end

    it 'finds or creates all of the release_classifications' do
      expect(find_or_create_release_classification).to have_received(:call).exactly(9).times
    end
  end
end
