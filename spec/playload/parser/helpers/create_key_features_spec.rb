# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateKeyFeatures do
  let(:result)           { described_class.new(new_params).call(call_params) }
  let(:data)             { File.read('spec/support/sample_data.json') }
  let(:game_details)     { JSON.parse(data)['GameInfo'][0] }

  let(:key_feature)      { build(:key_feature) }
  let(:publication)      { build(:publication) }

  let(:key_feature_repo) { instance_double KeyFeatureRepository }

  let(:new_params)       { Hash[key_feature_repo: key_feature_repo] }
  let(:call_params)      { Hash[game_details: game_details, publication: publication] }

  let(:create_params_1) do
    {
      text: game_details['key_features_list'][0]['key_features'],
      type: 'STD_ENG',
      region: 'English',
      std: true,
      publication_id: publication.id
    }
  end

  let(:create_params_2) do
    {
      text: game_details['key_features_list'][1]['key_features'],
      type: 'ENG',
      region: 'English',
      std: false,
      publication_id: publication.id
    }
  end

  describe '#call' do
    before do
      allow(key_feature_repo).to receive(:create)
    end

    context 'when the key_feature does not already exist' do
      before do
        allow(key_feature_repo).to receive(:find_by).and_return(nil)
        result
      end

      it 'tries to find the first key_feature in the database' do
        expect(key_feature_repo).to have_received(:find_by).with(text: create_params_1[:text])
      end

      it 'tries to find the second key_feature in the database' do
        expect(key_feature_repo).to have_received(:find_by).with(text: create_params_2[:text])
      end

      it 'creates both key_features' do
        expect(key_feature_repo).to have_received(:create).exactly(2).times
      end

      it 'creates the first key_feature' do
        expect(key_feature_repo).to have_received(:create).with(create_params_1)
      end

      it 'creates the second key_feature' do
        expect(key_feature_repo).to have_received(:create).with(create_params_2)
      end
    end

    context 'when one of the key_features already exists' do
      before do
        allow(key_feature_repo).to receive(:find_by).with(text: create_params_1[:text]).and_return(key_feature)
        allow(key_feature_repo).to receive(:find_by).with(text: create_params_2[:text]).and_return(nil)
        result
      end

      it 'tries to find the first key_feature in the database' do
        expect(key_feature_repo).to have_received(:find_by).with(text: create_params_1[:text])
      end

      it 'tries to find the second key_feature in the database' do
        expect(key_feature_repo).to have_received(:find_by).with(text: create_params_2[:text])
      end

      it 'does not create the first key_feature' do
        expect(key_feature_repo).not_to have_received(:create).with(create_params_1)
      end

      it 'creates the second key_feature' do
        expect(key_feature_repo).to have_received(:create).with(create_params_2)
      end
    end
  end
end
