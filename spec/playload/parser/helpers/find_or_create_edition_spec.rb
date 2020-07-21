# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreateEdition do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:edition)     { build(:edition) }
  let(:publication) { build(:publication) }

  let(:edition_repo)             { instance_double EditionRepository }
  let(:publication_edition_repo) { instance_double PublicationEditionRepository }

  let(:call_params) { Hash[game_details: game_details, publication: publication] }

  let(:new_params) do
    {
      edition_repo: edition_repo,
      publication_edition_repo: publication_edition_repo
    }
  end

  describe '#call' do
    before do
      allow(edition_repo).to receive(:find).and_return(nil)
      allow(edition_repo).to receive(:create).and_return(edition)
      allow(publication_edition_repo).to receive(:create)
      result
    end

    describe 'creating editions' do
      it 'tries to find the edition in the database' do
        expect(edition_repo).to have_received(:find).with(5729)
      end

      it 'creates only one edition' do
        expect(edition_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the edition' do
        expect(edition_repo).to have_received(:create).with(id: 5729, name: 'Deluxe Edition')
      end

      it 'creates only one publication_edition' do
        expect(publication_edition_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the publication_edition' do
        expect(publication_edition_repo).to have_received(:create)
          .with(publication_id: publication.id, edition_id: edition.id)
      end
    end
  end
end
