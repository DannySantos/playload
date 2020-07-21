# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateScreenshots do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:screenshot)   { build(:screenshot) }
  let(:release)      { build(:release) }
  let(:uuid)         { Container['helpers.build_uuid'].call }

  let(:new_params)   { Hash[screenshot_repo: screenshot_repo, build_uuid: build_uuid] }
  let(:call_params)  { Hash[game_details: game_details, release: release] }

  let(:screenshot_repo) { instance_double ScreenshotRepository }
  let(:build_uuid)      { instance_double Helpers::BuildUuid }

  before do
    allow(build_uuid).to receive(:call).and_return(uuid)
  end

  describe '#call' do
    before do
      allow(screenshot_repo).to receive(:create)
    end

    context 'when the screenshot does not already exist' do
      before do
        allow(screenshot_repo).to receive(:find_by).and_return(nil)
        result
      end

      it 'tries to find the screenshots in the database' do
        expect(screenshot_repo).to have_received(:find_by).exactly(46).times
      end

      it 'creates all of the screenshots' do
        expect(screenshot_repo).to have_received(:create).exactly(46).times
      end

      it 'creates the original screenshots' do
        expect(screenshot_repo).to have_received(:create)
          .with(url: anything, type: 'original', release_id: release.id, group_id: anything)
          .exactly(10).times
      end
    end

    context 'when the screenshot already exists' do
      before do
        allow(screenshot_repo).to receive(:find_by).and_return(screenshot)
        result
      end

      it 'tries to find the screenshot in the database' do
        expect(screenshot_repo).to have_received(:find_by).exactly(46).times
      end

      it 'does not create the screenshots' do
        expect(screenshot_repo).not_to have_received(:create)
      end
    end
  end
end
