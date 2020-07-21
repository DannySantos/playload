# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateDevelopers do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:release)      { build(:release) }
  let(:developer)    { build(:developer) }

  let(:developer_repo)         { instance_double DeveloperRepository }
  let(:release_developer_repo) { instance_double ReleaseDeveloperRepository }

  let(:call_params) { Hash[game_details: game_details, release: release] }

  let(:new_params) do
    {
      developer_repo: developer_repo,
      release_developer_repo: release_developer_repo
    }
  end

  describe '#call' do
    before do
      allow(developer_repo).to receive(:find).and_return(nil)
      allow(developer_repo).to receive(:create).and_return(developer)
      allow(release_developer_repo).to receive(:create)
      result
    end

    describe 'creating developers' do
      it 'tries to find the developer in the database' do
        expect(developer_repo).to have_received(:find).with(7478)
      end

      it 'creates only one developer' do
        expect(developer_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the developer' do
        expect(developer_repo).to have_received(:create).with(id: 7478, name: 'Capcom Co., Ltd.')
      end

      it 'creates only one release_developer' do
        expect(release_developer_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the release_developer' do
        create_params = { release_id: release.id, developer_id: developer.id }
        expect(release_developer_repo).to have_received(:create).with(create_params)
      end
    end
  end
end
