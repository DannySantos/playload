# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateCovers do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:cover)        { build(:cover) }
  let(:release)      { build(:release) }
  let(:uuid)         { Container['helpers.build_uuid'].call }

  let(:new_params)   { Hash[cover_repo: cover_repo, build_uuid: build_uuid] }
  let(:call_params)  { Hash[game_details: game_details, release: release] }

  let(:cover_repo)   { instance_double CoverRepository }
  let(:build_uuid)   { instance_double Helpers::BuildUuid }

  before do
    allow(build_uuid).to receive(:call).and_return(uuid)
  end

  describe '#call' do
    before do
      allow(cover_repo).to receive(:create)
    end

    context 'when the cover does not already exist' do
      before do
        allow(cover_repo).to receive(:find_by).and_return(nil)
        result
      end

      it 'tries to find the original cover in the database' do
        url = 'https://s3.amazonaws.com/gameopedia_covers/covers/883313/a999b7865101515a32bcbb18c57eb5ae.jpg'
        expect(cover_repo).to have_received(:find_by).with(url: url)
      end

      it 'tries to find all of the covers in the database' do
        game_details['cover']['other_resolutions']&.each do |resolution|
          expect(cover_repo).to have_received(:find_by).with(url: resolution['url'])
        end
      end

      it 'creates the original cover' do
        url = 'https://s3.amazonaws.com/gameopedia_covers/covers/883313/a999b7865101515a32bcbb18c57eb5ae.jpg'
        expect(cover_repo).to have_received(:create)
          .with(url: url, type: 'original', group_id: anything, release_id: release.id)
      end

      it 'creates all of the covers' do
        game_details['cover']['other_resolutions']&.each do |resolution|
          expect(cover_repo).to have_received(:create)
            .with(url: resolution['url'], type: resolution['type'], group_id: anything, release_id: release.id)
        end
      end
    end

    context 'when the cover already exists' do
      before do
        allow(cover_repo).to receive(:find_by).and_return(cover)
        result
      end

      it 'tries to find the original cover in the database' do
        url = 'https://s3.amazonaws.com/gameopedia_covers/covers/883313/a999b7865101515a32bcbb18c57eb5ae.jpg'
        expect(cover_repo).to have_received(:find_by).with(url: url)
      end

      it 'tries to find all of the covers in the database' do
        game_details['cover']['other_resolutions']&.each do |resolution|
          expect(cover_repo).to have_received(:find_by).with(url: resolution['url'])
        end
      end

      it 'does not create the covers' do
        expect(cover_repo).not_to have_received(:create)
      end
    end
  end
end
