# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength
# rubocop:disable RSpec/MultipleExpectations
RSpec.describe Parser::Parser do
  let(:result)       { described_class.new(new_params).call(data: data) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:game)         { build(:game) }
  let(:platform)     { build(:platform) }
  let(:release)      { build(:release) }
  let(:publication)  { build(:publication) }

  let(:game_repo)          { instance_double GameRepository }
  let(:release_repo)       { instance_double ReleaseRepository }
  let(:publication_repo)   { instance_double PublicationRepository }

  let(:create_game)        { instance_double Parser::Helpers::CreateGame }
  let(:create_release)     { instance_double Parser::Helpers::CreateRelease }
  let(:create_publication) { instance_double Parser::Helpers::CreatePublication }

  let(:update_game)        { instance_double Parser::Helpers::UpdateGame }
  let(:update_release)     { instance_double Parser::Helpers::UpdateRelease }
  let(:update_publication) { instance_double Parser::Helpers::UpdatePublication }

  let(:create_engines)             { instance_double Parser::Helpers::CreateEngines }
  let(:create_ratings)             { instance_double Parser::Helpers::CreateRatings }
  let(:create_developers)          { instance_double Parser::Helpers::CreateDevelopers }
  let(:create_regions)             { instance_double Parser::Helpers::CreateRegions }
  let(:create_publishers)          { instance_double Parser::Helpers::CreatePublishers }
  let(:create_reviews)             { instance_double Parser::Helpers::CreateReviews }
  let(:create_descriptions)        { instance_double Parser::Helpers::CreateDescriptions }
  let(:create_key_features)        { instance_double Parser::Helpers::CreateKeyFeatures }
  let(:create_alternative_titles)  { instance_double Parser::Helpers::CreateAlternativeTitles }
  let(:create_videos)              { instance_double Parser::Helpers::CreateVideos }
  let(:create_links)               { instance_double Parser::Helpers::CreateLinks }
  let(:create_screenshots)         { instance_double Parser::Helpers::CreateScreenshots }
  let(:create_covers)              { instance_double Parser::Helpers::CreateCovers }
  let(:create_classifications)     { instance_double Parser::Helpers::CreateClassifications }
  let(:create_tech_specs)          { instance_double Parser::Helpers::CreateTechSpecs }

  let(:find_or_create_platform) { instance_double Parser::Helpers::FindOrCreatePlatform }

  let(:new_params) do
    {
      game_repo: game_repo,
      release_repo: release_repo,
      publication_repo: publication_repo,
      create_game: create_game,
      create_release: create_release,
      create_publication: create_publication,
      update_game: update_game,
      update_release: update_release,
      update_publication: update_publication,
      find_or_create_platform: find_or_create_platform,
      create_engines: create_engines,
      create_ratings: create_ratings,
      create_developers: create_developers,
      create_regions: create_regions,
      create_publishers: create_publishers,
      create_reviews: create_reviews,
      create_descriptions: create_descriptions,
      create_key_features: create_key_features,
      create_alternative_titles: create_alternative_titles,
      create_videos: create_videos,
      create_links: create_links,
      create_screenshots: create_screenshots,
      create_covers: create_covers,
      create_classifications: create_classifications,
      create_tech_specs: create_tech_specs
    }
  end

  before do
    allow(game_repo).to receive(:find_by).and_return(nil)
    allow(release_repo).to receive(:find).and_return(nil)
    allow(publication_repo).to receive(:find_by).and_return(nil)

    allow(create_game).to receive(:call).and_return(game)
    allow(create_release).to receive(:call).and_return(release)
    allow(create_publication).to receive(:call).and_return(publication)

    allow(update_game).to receive(:call).and_return(game)
    allow(update_release).to receive(:call).and_return(release)
    allow(update_publication).to receive(:call).and_return(publication)

    allow(find_or_create_platform).to receive(:call).and_return(platform)

    allow(create_engines).to receive(:call)
    allow(create_ratings).to receive(:call)
    allow(create_developers).to receive(:call)
    allow(create_regions).to receive(:call)
    allow(create_publishers).to receive(:call)
    allow(create_reviews).to receive(:call)
    allow(create_descriptions).to receive(:call)
    allow(create_key_features).to receive(:call)
    allow(create_alternative_titles).to receive(:call)
    allow(create_videos).to receive(:call)
    allow(create_links).to receive(:call)
    allow(create_screenshots).to receive(:call)
    allow(create_covers).to receive(:call)
    allow(create_classifications).to receive(:call)
    allow(create_tech_specs).to receive(:call)
  end

  describe '#call' do
    context 'when creating a game' do
      before do
        result
      end

      it 'calls all of the create helpers', :aggregate_failures do
        expect(game_repo).to have_received(:find_by).with(title: 'Resident Evil 2')
        expect(release_repo).to have_received(:find).with(88107)
        expect(publication_repo).to have_received(:find_by)
          .with(gameopedia_id: '88107-13-5729-Online (Playstation Network)')

        expect(create_game).to have_received(:call).with(game_details: game_details)
        expect(create_release).to have_received(:call)
          .with(game_details: game_details, game: game, platform: platform)
        expect(create_publication).to have_received(:call).with(game_details: game_details, release: release)

        expect(update_game).not_to have_received(:call)
        expect(update_release).not_to have_received(:call)
        expect(update_publication).not_to have_received(:call)

        expect(find_or_create_platform).to have_received(:call).with(game_details: game_details)

        expect(create_engines).to have_received(:call).with(game_details: game_details, game: game)
        expect(create_ratings).to have_received(:call).with(game_details: game_details, release: release)
        expect(create_developers).to have_received(:call).with(game_details: game_details, release: release)
        expect(create_regions).to have_received(:call).with(game_details: game_details, publication: publication)
        expect(create_publishers).to have_received(:call).with(game_details: game_details, publication: publication)
        expect(create_reviews).to have_received(:call).with(game_details: game_details, release: release)
        expect(create_descriptions).to have_received(:call).with(game_details: game_details, publication: publication)
        expect(create_key_features).to have_received(:call).with(game_details: game_details, publication: publication)
        expect(create_alternative_titles).to have_received(:call).with(game_details: game_details, release: release)
        expect(create_videos).to have_received(:call).with(game_details: game_details, release: release)
        expect(create_links).to have_received(:call).with(game_details: game_details, release: release)
        expect(create_screenshots).to have_received(:call).with(game_details: game_details, release: release)
        expect(create_covers).to have_received(:call).with(game_details: game_details, release: release)
        expect(create_classifications).to have_received(:call).with(game_details: game_details, release: release)
        expect(create_tech_specs).to have_received(:call).with(game_details: game_details, release: release)
      end
    end
  end

  context 'when the game already exists in the database' do
    before do
      allow(game_repo).to receive(:find_by).and_return(game)
      allow(release_repo).to receive(:find).and_return(release)
      allow(publication_repo).to receive(:find_by).and_return(publication)
      result
    end

    it 'calls create helpers and update helpers', :aggregate_failures do
      expect(game_repo).to have_received(:find_by).with(title: 'Resident Evil 2')
      expect(release_repo).to have_received(:find).with(88107)
      expect(publication_repo).to have_received(:find_by)
        .with(gameopedia_id: '88107-13-5729-Online (Playstation Network)')

      expect(create_game).not_to have_received(:call)
      expect(create_release).not_to have_received(:call)
      expect(create_publication).not_to have_received(:call)

      expect(update_game).to have_received(:call).with(game_details: game_details, game: game)
      expect(update_release).to have_received(:call)
        .with(game_details: game_details, game: game, platform: platform, release: release)
      expect(update_publication).to have_received(:call)
        .with(game_details: game_details, publication: publication, release: release)

      expect(find_or_create_platform).to have_received(:call).with(game_details: game_details)

      expect(create_engines).to have_received(:call).with(game_details: game_details, game: game)
      expect(create_ratings).to have_received(:call).with(game_details: game_details, release: release)
      expect(create_developers).to have_received(:call).with(game_details: game_details, release: release)
      expect(create_regions).to have_received(:call).with(game_details: game_details, publication: publication)
      expect(create_publishers).to have_received(:call).with(game_details: game_details, publication: publication)
      expect(create_reviews).to have_received(:call).with(game_details: game_details, release: release)
      expect(create_descriptions).to have_received(:call).with(game_details: game_details, publication: publication)
      expect(create_key_features).to have_received(:call).with(game_details: game_details, publication: publication)
      expect(create_alternative_titles).to have_received(:call).with(game_details: game_details, release: release)
      expect(create_videos).to have_received(:call).with(game_details: game_details, release: release)
      expect(create_links).to have_received(:call).with(game_details: game_details, release: release)
      expect(create_screenshots).to have_received(:call).with(game_details: game_details, release: release)
      expect(create_covers).to have_received(:call).with(game_details: game_details, release: release)
      expect(create_classifications).to have_received(:call).with(game_details: game_details, release: release)
      expect(create_tech_specs).to have_received(:call).with(game_details: game_details, release: release)
    end
  end
end
# rubocop:enable RSpec/ExampleLength
# rubocop:enable RSpec/MultipleExpectations
