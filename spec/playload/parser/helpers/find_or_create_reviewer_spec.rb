# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreateReviewer do
  let(:result)        { described_class.new(new_params).call(review_details: review_details) }
  let(:new_params)    { Hash[reviewer_repo: reviewer_repo] }
  let(:call_params)   { Hash[review_details: review_details] }
  let(:reviewer_repo) { instance_double ReviewerRepository }
  let(:reviewer)      { build(:reviewer) }

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
    context 'when the reviewer does not exist' do
      before do
        allow(reviewer_repo).to receive(:find).and_return(nil)
        allow(reviewer_repo).to receive(:find_by).and_return(nil)
        allow(reviewer_repo).to receive(:create).and_return(reviewer)
        result
      end

      it 'tries to find the reviewer in the database by id' do
        expect(reviewer_repo).to have_received(:find).with(42)
      end

      it 'tries to find the reviewers in the database by name' do
        expect(reviewer_repo).to have_received(:find_by).with(name: 'Eurogamer.net')
      end

      it 'creates only one reviewer' do
        expect(reviewer_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the reviewer' do
        expect(reviewer_repo).to have_received(:create).with(id: 42, name: 'Eurogamer.net')
      end
    end

    context 'when the reviewer already exists' do
      before do
        allow(reviewer_repo).to receive(:find).and_return(reviewer)
        allow(reviewer_repo).to receive(:find_by).and_return(nil)
        allow(reviewer_repo).to receive(:create)
        result
      end

      it 'tries to find the reviewer in the database by id' do
        expect(reviewer_repo).to have_received(:find).with(42)
      end

      it 'tries to find the reviewers in the database by name' do
        expect(reviewer_repo).not_to have_received(:find_by)
      end

      it 'does not create the reviewer' do
        expect(reviewer_repo).not_to have_received(:create)
      end
    end
  end
end
