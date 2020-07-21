# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreateGame do
  let(:result)       { described_class.new(new_params).call(game_details: game_details) }
  let(:new_params)   { Hash[game_repo: game_repo] }
  let(:call_params)  { Hash[game_details: game_details] }
  let(:game_repo)    { instance_double GameRepository }
  let(:game)         { build(:game) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  describe '#call' do
    context 'when the game does not exist' do
      before do
        allow(game_repo).to receive(:find_by).and_return(nil)
        allow(game_repo).to receive(:create)
        result
      end

      it 'tries to find the game in the database' do
        expect(game_repo).to have_received(:find_by).with(title: 'Resident Evil 2')
      end

      it 'creates only one game' do
        expect(game_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the game' do
        expect(game_repo).to have_received(:create).with(
          title: 'Resident Evil 2',
          us_title: 'Resident Evil 2: Remake',
          uk_title: nil
        )
      end
    end

    context 'when the game already exists' do
      before do
        allow(game_repo).to receive(:find_by).and_return(game)
        allow(game_repo).to receive(:create)
        result
      end

      it 'tries to find the game in the database' do
        expect(game_repo).to have_received(:find_by).with(title: 'Resident Evil 2')
      end

      it 'does not create the game' do
        expect(game_repo).not_to have_received(:create)
      end
    end
  end
end
