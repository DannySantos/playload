# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreatePlatform do
  let(:result)        { described_class.new(new_params).call(game_details: game_details) }
  let(:new_params)    { Hash[platform_repo: platform_repo] }
  let(:call_params)   { Hash[game_details: game_details] }
  let(:platform_repo) { instance_double PlatformRepository }
  let(:platform)      { build(:platform) }
  let(:data)          { File.read('spec/support/sample_data.json') }
  let(:game_details)  { JSON.parse(data)['GameInfo'][0] }

  describe '#call' do
    context 'when the platform does not exist' do
      before do
        allow(platform_repo).to receive(:find).and_return(nil)
        allow(platform_repo).to receive(:create)
        result
      end

      it 'tries to find the platform in the database' do
        expect(platform_repo).to have_received(:find).with(191)
      end

      it 'creates only one platform' do
        expect(platform_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the platform' do
        expect(platform_repo).to have_received(:create).with(id: 191, name: 'PlayStation 4')
      end
    end

    context 'when the platform already exists' do
      before do
        allow(platform_repo).to receive(:find).and_return(platform)
        allow(platform_repo).to receive(:create)
        result
      end

      it 'tries to find the platform in the database' do
        expect(platform_repo).to have_received(:find).with(191)
      end

      it 'does not create the platform' do
        expect(platform_repo).not_to have_received(:create)
      end
    end
  end
end
