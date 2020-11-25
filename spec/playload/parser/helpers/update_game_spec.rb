# frozen_string_literal: true

RSpec.describe Parser::Helpers::UpdateGame do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:new_params)   { Hash[game_repo: game_repo] }
  let(:call_params)  { Hash[game_details: game_details, game: game] }
  let(:game_repo)    { instance_double GameRepository }
  let(:game)         { build(:game) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:game_attrs) do
    {
      title: 'Resident Evil 2',
      us_title: 'Resident Evil 2: Remake',
      uk_title: nil
    }
  end

  describe '#call' do
    before do
      allow(game_repo).to receive(:update)
      result
    end

    it 'updates the game' do
      expect(game_repo).to have_received(:update).with(game.id, game_attrs)
    end
  end
end
