# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateDescriptions do
  let(:result)           { described_class.new(new_params).call(call_params) }
  let(:data)             { File.read('spec/support/sample_data.json') }
  let(:game_details)     { JSON.parse(data)['GameInfo'][0] }

  let(:description)      { build(:description) }
  let(:publication)      { build(:publication) }

  let(:description_repo) { instance_double DescriptionRepository }

  let(:new_params)       { Hash[description_repo: description_repo] }
  let(:call_params)      { Hash[game_details: game_details, publication: publication] }

  let(:create_params) do
    {
      content: game_details['game_descriptions'][0]['game_description'],
      type: 'STD_ENG',
      region: 'English',
      std: true,
      publication_id: publication.id
    }
  end

  describe '#call' do
    before do
      allow(description_repo).to receive(:create)
    end

    context 'when the description does not already exist' do
      before do
        allow(description_repo).to receive(:find_by).and_return(nil)
        result
      end

      it 'tries to find the description in the database' do
        expect(description_repo).to have_received(:find_by).with(content: create_params[:content])
      end

      it 'creates only one description' do
        expect(description_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the description' do
        expect(description_repo).to have_received(:create).with(create_params)
      end
    end

    context 'when the description already exists' do
      before do
        allow(description_repo).to receive(:find_by).and_return(description)
        result
      end

      it 'tries to find the description in the database' do
        expect(description_repo).to have_received(:find_by).with(content: create_params[:content])
      end

      it 'does not create the description' do
        expect(description_repo).not_to have_received(:create)
      end
    end
  end
end
