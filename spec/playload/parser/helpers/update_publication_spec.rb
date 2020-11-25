# frozen_string_literal: true

RSpec.describe Parser::Helpers::UpdatePublication do
  let(:result)           { described_class.new(new_params).call(call_params) }
  let(:new_params)       { Hash[publication_repo: publication_repo] }
  let(:call_params)      { Hash[game_details: game_details, release: release, publication: publication] }
  let(:publication_repo) { instance_double PublicationRepository }
  let(:release)          { build(:release) }
  let(:publication)      { build(:publication) }
  let(:data)             { File.read('spec/support/sample_data.json') }
  let(:game_details)     { JSON.parse(data)['GameInfo'][0] }

  let(:update_attrs) do
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
    before do
      allow(publication_repo).to receive(:update)
      result
    end

    it 'updates the game' do
      expect(publication_repo).to have_received(:update).with(publication.id, update_attrs)
    end
  end
end
