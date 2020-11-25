# frozen_string_literal: true

RSpec.describe Parser::Helpers::UpdateRelease do
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
      platform: platform,
      release: release
    }
  end

  let(:update_params) do
    {
      updated_by_gameopedia: Time.parse(game_details['updated']),
      game_id: game.id,
      platform_id: platform.id
    }
  end

  describe '#call' do
    before do
      allow(release_repo).to receive(:update)
      result
    end

    it 'does not update the release' do
      expect(release_repo).to have_received(:update).with(release.id, update_params)
    end
  end
end
