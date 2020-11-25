# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateRegions do
  let(:result)             { described_class.new(new_params).call(call_params) }
  let(:data)               { File.read('spec/support/sample_data.json') }
  let(:game_details)       { JSON.parse(data)['GameInfo'][0] }

  let(:release)            { build(:release) }
  let(:publication)        { build(:publication) }
  let(:region)             { build(:region) }
  let(:updated_region)     { build(:region) }
  let(:publication_region) { build(:publication_region) }

  let(:region_repo)                       { instance_double RegionRepository }
  let(:find_or_create_publication_region) { instance_double Parser::Helpers::FindOrCreatePublicationRegion }

  let(:new_params) do
    {
      region_repo: region_repo,
      find_or_create_publication_region: find_or_create_publication_region
    }
  end

  let(:call_params) do
    {
      game_details: game_details,
      publication: publication
    }
  end

  describe '#call' do
    before do
      allow(region_repo).to receive(:update).and_return(updated_region)
      allow(region_repo).to receive(:create).and_return(region)
      allow(find_or_create_publication_region).to receive(:call).and_return(publication_region)
    end

    context 'when the region does not yet exist' do
      before do
        allow(region_repo).to receive(:find).and_return(nil)
        result
      end

      it 'tries to find the region in the database' do
        expect(region_repo).to have_received(:find).with(13)
      end

      it 'does not update the region' do
        expect(region_repo).not_to have_received(:update)
      end

      it 'creates only one region' do
        expect(region_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the region' do
        expect(region_repo).to have_received(:create).with(id: 13, name: 'United Kingdom')
      end

      it 'does not create the publication_region with the updated region' do
        expect(find_or_create_publication_region).not_to have_received(:call)
          .with(publication: publication, region: updated_region)
      end

      it 'creates the publication_region with the newly created region' do
        expect(find_or_create_publication_region).to have_received(:call)
          .with(publication: publication, region: region)
      end
    end

    context 'when a region has already been created' do
      let(:region) { build(:region) }

      before do
        allow(region_repo).to receive(:find).and_return(region)
        result
      end

      it 'tries to find the region in the database' do
        expect(region_repo).to have_received(:find).with(13)
      end

      it 'does not update the region' do
        expect(region_repo).not_to have_received(:update)
      end

      it 'does not create any regions' do
        expect(region_repo).not_to have_received(:create)
      end

      it 'does not create the publication_region' do
        expect(find_or_create_publication_region).not_to have_received(:call)
      end
    end

    context 'when a region has already been created but has no name' do
      let(:region) { build(:region, name: nil) }

      before do
        allow(region_repo).to receive(:find).and_return(region)
        result
      end

      it 'tries to find the region in the database' do
        expect(region_repo).to have_received(:find).with(13)
      end

      it 'updates only one region' do
        expect(region_repo).to have_received(:update).exactly(1).times
      end

      it 'updates the region' do
        expect(region_repo).to have_received(:update).with(region.id, name: 'United Kingdom')
      end

      it 'does not create any regions' do
        expect(region_repo).not_to have_received(:create)
      end

      it 'creates the publication_region with the updated region' do
        expect(find_or_create_publication_region).to have_received(:call)
          .with(publication: publication, region: updated_region)
      end

      it 'does not create the publication_region with the newly created region' do
        expect(find_or_create_publication_region).not_to have_received(:call)
          .with(publication: publication, region: region)
      end
    end
  end
end
