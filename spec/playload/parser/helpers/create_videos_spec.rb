# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateVideos do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }
  let(:video_detail) { game_details['videos'][0] }

  let(:video)        { build(:video) }
  let(:release)      { build(:release) }

  let(:new_params)   { Hash[video_repo: video_repo] }
  let(:call_params)  { Hash[game_details: game_details, release: release] }

  let(:video_repo)   { instance_double VideoRepository }

  describe '#call' do
    before do
      allow(video_repo).to receive(:create)
    end

    context 'when the video does not already exist' do
      before do
        allow(video_repo).to receive(:find_by).and_return(nil)
        result
      end

      it 'tries to find the video in the database' do
        expect(video_repo).to have_received(:find_by).with(url: video_detail['url'])
      end

      it 'creates only one video' do
        expect(video_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the video' do
        expect(video_repo).to have_received(:create)
          .with(video_detail.transform_keys(&:to_sym).merge(release_id: release.id))
      end
    end

    context 'when the video already exists' do
      before do
        allow(video_repo).to receive(:find_by).and_return(video)
        result
      end

      it 'tries to find the video in the database' do
        expect(video_repo).to have_received(:find_by).with(url: video_detail['url'])
      end

      it 'does not create the videos' do
        expect(video_repo).not_to have_received(:create)
      end
    end
  end
end
