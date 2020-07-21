# frozen_string_literal: true

module Parser
  class Parser
    include Import[
      game_repo: 'repositories.game',
      platform_repo: 'repositories.platform',
      release_repo: 'repositories.release',
      find_or_create_game: 'parser.helpers.find_or_create_game',
      find_or_create_platform: 'parser.helpers.find_or_create_platform',
      find_or_create_release: 'parser.helpers.find_or_create_release',
      find_or_create_publication: 'parser.helpers.find_or_create_publication',
      create_engines: 'parser.helpers.create_engines',
      create_ratings: 'parser.helpers.create_ratings',
      create_developers: 'parser.helpers.create_developers',
      create_regions: 'parser.helpers.create_regions',
      create_publishers: 'parser.helpers.create_publishers',
      create_reviews: 'parser.helpers.create_reviews',
      create_descriptions: 'parser.helpers.create_descriptions',
      create_key_features: 'parser.helpers.create_key_features',
      create_alternative_titles: 'parser.helpers.create_alternative_titles',
      create_videos: 'parser.helpers.create_videos',
      create_links: 'parser.helpers.create_links',
      create_screenshots: 'parser.helpers.create_screenshots',
      create_covers: 'parser.helpers.create_covers',
      create_classifications: 'parser.helpers.create_classifications',
      create_tech_specs: 'parser.helpers.create_tech_specs'
    ]

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def call(data:)
      data = JSON.parse(data)
      games = data['GameInfo']

      games.each do |game_details|
        game = find_or_create_game.call(game_details: game_details)
        platform = find_or_create_platform.call(game_details: game_details)
        release = find_or_create_release.call(game_details: game_details, game: game, platform: platform)
        publication = find_or_create_publication.call(game_details: game_details, release: release)

        create_engines.call(game_details: game_details, game: game)
        create_ratings.call(game_details: game_details, release: release)
        create_developers.call(game_details: game_details, release: release)
        create_regions.call(game_details: game_details, publication: publication)
        create_publishers.call(game_details: game_details, publication: publication)
        create_reviews.call(game_details: game_details, release: release)
        create_descriptions.call(game_details: game_details, publication: publication)
        create_key_features.call(game_details: game_details, publication: publication)
        create_alternative_titles.call(game_details: game_details, release: release)
        create_videos.call(game_details: game_details, release: release)
        create_links.call(game_details: game_details, release: release)
        create_screenshots.call(game_details: game_details, release: release)
        create_covers.call(game_details: game_details, release: release)
        create_classifications.call(game_details: game_details, release: release)
        create_tech_specs.call(game_details: game_details, release: release)
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
  end
end
