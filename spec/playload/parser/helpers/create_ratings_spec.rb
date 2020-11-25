# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateRatings do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:release)            { build(:release) }
  let(:rating)             { build(:rating) }
  let(:rating_description) { build(:rating_description) }

  let(:rating_repo)                     { instance_double RatingRepository }
  let(:release_rating_repo)             { instance_double ReleaseRatingRepository }
  let(:rating_description_repo)         { instance_double RatingDescriptionRepository }
  let(:release_rating_description_repo) { instance_double ReleaseRatingDescriptionRepository }

  let(:call_params) { Hash[game_details: game_details, release: release] }

  let(:new_params) do
    {
      rating_repo: rating_repo,
      release_rating_repo: release_rating_repo,
      rating_description_repo: rating_description_repo,
      release_rating_description_repo: release_rating_description_repo
    }
  end

  describe '#call' do
    before do
      allow(rating_repo).to receive(:find_by).and_return(nil)
      allow(rating_repo).to receive(:create).and_return(rating)
      allow(release_rating_repo).to receive(:create)
      allow(rating_description_repo).to receive(:find_by).and_return(nil)
      allow(rating_description_repo).to receive(:create).and_return(rating_description)
      allow(release_rating_description_repo).to receive(:create)
      result
    end

    context 'when creating ratings' do
      it 'tries to find the rating in the database' do
        expect(rating_repo).to have_received(:find_by).with(name: '18+')
      end

      it 'creates only one rating' do
        expect(rating_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the rating' do
        expect(rating_repo).to have_received(:create).with(name: '18+')
      end

      it 'creates only one release_rating' do
        expect(release_rating_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the release_rating' do
        expect(release_rating_repo).to have_received(:create).with(release_id: release.id, rating_id: rating.id)
      end
    end

    context 'when creating rating descriptions' do
      it 'tries to find the first rating_description in the database' do
        expect(rating_description_repo).to have_received(:find_by).with(name: 'Violence')
      end

      it 'tries to find the second rating_description in the database' do
        expect(rating_description_repo).to have_received(:find_by).with(name: 'Bad Language')
      end

      it 'creates two rating_descriptions' do
        expect(rating_description_repo).to have_received(:create).exactly(2).times
      end

      it 'creates the first rating_description' do
        expect(rating_description_repo).to have_received(:create).with(name: 'Violence')
      end

      it 'creates the second rating_description' do
        expect(rating_description_repo).to have_received(:create).with(name: 'Bad Language')
      end
    end
  end
end
