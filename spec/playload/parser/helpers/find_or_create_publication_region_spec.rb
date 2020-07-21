# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreatePublicationRegion do
  let(:result)      { described_class.new(new_params).call(call_params) }
  let(:new_params)  { Hash[publication_region_repo: publication_region_repo] }
  let(:publication) { build(:publication) }
  let(:region)      { build(:region) }

  let(:publication_region_repo) { instance_double PublicationRepository }

  let(:call_params) do
    {
      publication: publication,
      region: region
    }
  end

  let(:publication_region_params) do
    {
      publication_id: publication.id,
      region_id: region.id
    }
  end

  describe '#call' do
    context 'when the publication region does not exist' do
      before do
        allow(publication_region_repo).to receive(:find_by).and_return(nil)
        allow(publication_region_repo).to receive(:create)
        result
      end

      it 'tries to find the publication region in the database' do
        expect(publication_region_repo).to have_received(:find_by).with(publication_region_params)
      end

      it 'creates only one publication' do
        expect(publication_region_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the publication' do
        expect(publication_region_repo).to have_received(:create).with(publication_region_params)
      end
    end

    context 'when the publication region already exists' do
      before do
        allow(publication_region_repo).to receive(:find_by).and_return(publication)
        allow(publication_region_repo).to receive(:create)
        result
      end

      it 'tries to find the publication region in the database' do
        expect(publication_region_repo).to have_received(:find_by).with(publication_region_params)
      end

      it 'does not create the publication' do
        expect(publication_region_repo).not_to have_received(:create)
      end
    end
  end
end
