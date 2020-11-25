# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreatePublication do
  let(:result)           { described_class.new(new_params).call(call_params) }
  let(:new_params)       { Hash[publication_repo: publication_repo] }
  let(:publication_repo) { instance_double PublicationRepository }
  let(:publication)      { build(:publication) }
  let(:release)          { build(:release) }
  let(:game)             { build(:game) }
  let(:platform)         { build(:platform) }
  let(:data)             { File.read('spec/support/sample_data.json') }
  let(:game_details)     { JSON.parse(data)['GameInfo'][0] }

  let(:call_params) do
    {
      game_details: game_details,
      release: release
    }
  end

  let(:create_params) do
    {
      title: 'Resident Evil 2',
      gameopedia_id: '88107-13-5729-Online (Playstation Network)',
      release_id: release.id,
      barcode: nil,
      gameopedia_release_date: '25-01-2019',
      release_date: Time.parse('25-01-2019'),
      distribution: 'Online (Playstation Network)'
    }
  end

  describe '#call' do
    context 'when the publication does not exist' do
      before do
        allow(publication_repo).to receive(:find_by).and_return(nil)
        allow(publication_repo).to receive(:create)
        result
      end

      it 'tries to find the publication in the database' do
        expect(publication_repo).to have_received(:find_by)
          .with(gameopedia_id: '88107-13-5729-Online (Playstation Network)')
      end

      it 'creates only one publication' do
        expect(publication_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the publication' do
        expect(publication_repo).to have_received(:create).with(create_params)
      end
    end

    context 'when the publication already exists' do
      before do
        allow(publication_repo).to receive(:find_by).and_return(publication)
        allow(publication_repo).to receive(:create)
        result
      end

      it 'tries to find the publication in the database' do
        expect(publication_repo).to have_received(:find_by)
          .with(gameopedia_id: '88107-13-5729-Online (Playstation Network)')
      end

      it 'does not create the publication' do
        expect(publication_repo).not_to have_received(:create)
      end
    end
  end
end
