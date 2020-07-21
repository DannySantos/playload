# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateReviews do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:release)      { build(:release) }
  let(:reviewer)     { build(:reviewer) }
  let(:region)       { build(:region) }

  let(:review_repo)  { instance_double ReviewRepository }

  let(:find_or_create_reviewer) { instance_double Parser::Helpers::FindOrCreateReviewer }
  let(:find_or_create_region)   { instance_double Parser::Helpers::FindOrCreateRegion }

  let(:call_params) { Hash[game_details: game_details, release: release] }

  let(:new_params) do
    {
      review_repo: review_repo,
      find_or_create_reviewer: find_or_create_reviewer,
      find_or_create_region: find_or_create_region
    }
  end

  let(:create_params) do
    lambda { |rating_value, link_value|
      {
        release_id: release.id,
        reviewer_id: reviewer.id,
        region_id: region.id,
        rating: rating_value,
        link: link_value
      }
    }
  end

  describe '#call' do
    before do
      allow(review_repo).to receive(:find_by).and_return(nil)
      allow(review_repo).to receive(:create)
      allow(find_or_create_reviewer).to receive(:call).and_return(reviewer)
      allow(find_or_create_region).to receive(:call).and_return(region)
      result
    end

    describe 'creating reviews' do
      it 'tries to find the reviews in the database' do
        expect(review_repo).to have_received(:find_by)
          .with(release_id: release.id, reviewer_id: reviewer.id, region_id: region.id)
          .exactly(7).times
      end

      it 'creates all of the reviews' do
        expect(review_repo).to have_received(:create).exactly(7).times
      end

      it 'creates the GamesRadar review' do
        expect(review_repo).to have_received(:create).with(
          create_params['4/5', 'https://www.gamesradar.com/resident-evil-2-remake-review/']
        )
      end

      it 'creates the IGN review' do
        expect(review_repo).to have_received(:create).with(
          create_params['9/10', 'https://www.ign.com/articles/2019/01/22/resident-evil-2-review']
        )
      end

      it 'creates the Gamespot review' do
        link = 'https://www.gamespot.com/reviews/resident-evil-2-review-re-viving-nightmares/1900-6417071/'

        expect(review_repo).to have_received(:create).with(
          create_params['9/10', link]
        )
      end

      it 'creates the Guardian review' do
        link = 'https://www.theguardian.com/games/2019/jan/22/resident-evil-2-review-genre-defining-horror-loaded-with-dread'

        expect(review_repo).to have_received(:create).with(
          create_params['5/5', link]
        )
      end

      it 'creates the Eurogamer review' do
        expect(review_repo).to have_received(:create).with(
          create_params['/10', 'https://www.eurogamer.net/articles/2019-01-22-resident-evil-2-review']
        )
      end

      it 'creates the Destructoid review' do
        expect(review_repo).to have_received(:create).with(
          create_params['9/10', 'https://www.destructoid.com/review-resident-evil-2-2019--538881.phtml']
        )
      end

      it 'creates the Game Informer review' do
        expect(review_repo).to have_received(:create).with(
          create_params['9.5/10', 'https://www.gameinformer.com/Resident%20Evil%202%20game%20informer%20Review']
        )
      end

      it 'creates the correct number of reviewers' do
        expect(find_or_create_reviewer).to have_received(:call).exactly(7).times
      end

      it 'creates the reviewers' do
        game_details['reviews'].each do |review_details|
          expect(find_or_create_reviewer).to have_received(:call).with(review_details: review_details)
        end
      end

      it 'creates the correct number of regions' do
        expect(find_or_create_region).to have_received(:call).exactly(7).times
      end

      it 'creates the regions' do
        game_details['reviews'].each do |review_details|
          expect(find_or_create_region).to have_received(:call).with(review_details: review_details)
        end
      end
    end
  end
end
