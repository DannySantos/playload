# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateAlternativeTitles do
  let(:result)            { described_class.new(new_params).call(call_params) }
  let(:data)              { File.read('spec/support/sample_data.json') }
  let(:game_details)      { JSON.parse(data)['GameInfo'][0] }

  let(:alternative_title) { build(:alternative_title) }
  let(:release)           { build(:release) }

  let(:new_params)        { Hash[alternative_title_repo: alternative_title_repo] }
  let(:call_params)       { Hash[game_details: game_details, release: release] }

  let(:alternative_title_repo) { instance_double AlternativeTitleRepository }

  describe '#call' do
    before do
      allow(alternative_title_repo).to receive(:create)
    end

    context 'when the alternative_title does not already exist' do
      before do
        allow(alternative_title_repo).to receive(:find_by).and_return(nil)
        result
      end

      it 'tries to find the alternative_titles in the database' do
        game_details['alternative_titles'].each do |alternative_title_detail|
          expect(alternative_title_repo).to have_received(:find_by).with(title: alternative_title_detail)
        end
      end

      it 'creates all alternative_titles' do
        expect(alternative_title_repo).to have_received(:create).exactly(5).times
      end

      it 'creates the alternative_titles' do
        game_details['alternative_titles'].each do |alternative_title_detail|
          expect(alternative_title_repo).to have_received(:create)
            .with(title: alternative_title_detail, release_id: release.id)
        end
      end
    end

    context 'when the alternative_titles already exist' do
      before do
        allow(alternative_title_repo).to receive(:find_by).and_return(alternative_title)
        result
      end

      it 'tries to find the alternative_titles in the database' do
        game_details['alternative_titles'].each do |alternative_title_detail|
          expect(alternative_title_repo).to have_received(:find_by).with(title: alternative_title_detail)
        end
      end

      it 'does not create the alternative_titles' do
        expect(alternative_title_repo).not_to have_received(:create)
      end
    end
  end
end
