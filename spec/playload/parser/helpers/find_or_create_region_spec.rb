# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreateRegion do
  let(:result)      { described_class.new(new_params).call(review_details: review_details) }
  let(:new_params)  { Hash[region_repo: region_repo] }
  let(:call_params) { Hash[review_details: review_details] }
  let(:region_repo) { instance_double RegionRepository }
  let(:region)      { build(:region) }

  let(:review_details) do
    JSON.parse('{
      "reviewer": "Eurogamer.net",
      "reviewer_id": "42",
      "locality_id": "13",
      "rating": "/10",
      "link": "https://www.eurogamer.net/articles/2019-01-22-resident-evil-2-review"
    }')
  end

  describe '#call' do
    context 'when the region does not exist' do
      before do
        allow(region_repo).to receive(:find).and_return(nil)
        allow(region_repo).to receive(:create).and_return(region)
        result
      end

      it 'tries to find the region in the database by id' do
        expect(region_repo).to have_received(:find).with(13)
      end

      it 'creates only one region' do
        expect(region_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the region' do
        expect(region_repo).to have_received(:create).with(id: 13, name: nil)
      end
    end

    context 'when the region already exists' do
      before do
        allow(region_repo).to receive(:find).and_return(region)
        allow(region_repo).to receive(:create)
        result
      end

      it 'tries to find the region in the database by id' do
        expect(region_repo).to have_received(:find).with(13)
      end

      it 'does not create the region' do
        expect(region_repo).not_to have_received(:create)
      end
    end
  end
end
