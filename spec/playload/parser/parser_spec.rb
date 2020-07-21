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

  let(:find_or_create_game)        { instance_double Parser::Helpers::FindOrCreateGame }
  let(:find_or_create_platform)    { instance_double Parser::Helpers::FindOrCreatePlatform }
  let(:find_or_create_release)     { instance_double Parser::Helpers::FindOrCreateRelease }
  let(:find_or_create_publication) { instance_double Parser::Helpers::FindOrCreatePublication }

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

  let(:new_params) do
    {
      find_or_create_game: find_or_create_game,
      find_or_create_platform: find_or_create_platform,
      find_or_create_release: find_or_create_release,
      find_or_create_publication: find_or_create_publication,
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
    allow(find_or_create_game).to receive(:call).and_return(game)
    allow(find_or_create_platform).to receive(:call).and_return(platform)
    allow(find_or_create_release).to receive(:call).and_return(release)
    allow(find_or_create_publication).to receive(:call).and_return(publication)

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
    result
  end

  describe '#call' do
    it 'calls all of the create helpers' do
      expect(find_or_create_game).to have_received(:call).with(game_details: game_details)
      expect(find_or_create_platform).to have_received(:call).with(game_details: game_details)
      expect(find_or_create_release).to have_received(:call)
        .with(game_details: game_details, game: game, platform: platform)
      expect(find_or_create_publication).to have_received(:call).with(game_details: game_details, release: release)

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
