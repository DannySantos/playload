# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateRelease do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:new_params)   { Hash[release_repo: release_repo] }
  let(:release_repo) { instance_double ReleaseRepository }
  let(:release)      { build(:release) }
  let(:game)         { build(:game) }
  let(:platform)     { build(:platform) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:call_params) do
    {
      game_details: game_details,
      game: game,
      platform: platform
    }
  end

  let(:create_params) do
    {
      id: game_details['release_id'],
      updated_by_gameopedia: Time.parse(game_details['updated']),
      game_id: game.id,
      platform_id: platform.id
    }
  end

  describe '#call' do
    context 'when the release does not exist' do
      before do
        allow(release_repo).to receive(:find).and_return(nil)
        allow(release_repo).to receive(:create)
        result
      end

      it 'tries to find the release in the database' do
        expect(release_repo).to have_received(:find).with(88_107)
      end

      it 'creates only one release' do
        expect(release_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the release' do
        expect(release_repo).to have_received(:create).with(create_params)
      end
    end

    context 'when the release already exists' do
      before do
        allow(release_repo).to receive(:find).and_return(release)
        allow(release_repo).to receive(:create)
        result
      end

      it 'tries to find the release in the database' do
        expect(release_repo).to have_received(:find).with(88_107)
      end

      it 'does not create the release' do
        expect(release_repo).not_to have_received(:create)
      end
    end
  end
end
