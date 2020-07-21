# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateEngines do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:game)         { build(:game) }

  let(:new_params)   { Hash[engine_repo: engine_repo, game_engine_repo: game_engine_repo] }
  let(:call_params)  { Hash[game_details: game_details, game: game] }

  let(:engine_repo)      { instance_double EngineRepository }
  let(:game_engine_repo) { instance_double GameEngineRepository }

  describe '#call' do
    before do
      allow(engine_repo).to receive(:find_by)
      allow(engine_repo).to receive(:create)
      allow(game_engine_repo).to receive(:create)
      result
    end

    describe 'creating engines' do
      it 'tries to find the game in the database' do
        expect(engine_repo).not_to have_received(:find_by)
      end

      it 'does not create any engines' do
        expect(engine_repo).not_to have_received(:create)
      end

      it 'does not create any game_engines' do
        expect(game_engine_repo).not_to have_received(:create)
      end
    end
  end
end
