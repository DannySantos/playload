# frozen_string_literal: true

module Parser
  class Parser
    include Import[
      game_repo: 'repositories.game',
      release_repo: 'repositories.release',
      publication_repo: 'repositories.publication',
      create_game: 'parser.helpers.create_game',
      create_release: 'parser.helpers.create_release',
      create_publication: 'parser.helpers.create_publication',
      update_game: 'parser.helpers.update_game',
      update_release: 'parser.helpers.update_release',
      update_publication: 'parser.helpers.update_publication',
      find_or_create_platform: 'parser.helpers.find_or_create_platform',
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

    def call(data:)
      games = JSON.parse(data)['GameInfo']

      games.each do |game_details|
        game = handle_game(game_details)
        platform = find_or_create_platform.call(game_details: game_details)
        release = handle_release(game_details, game, platform)
        publication = handle_publication(game_details, release)
        create_engines.call(game_details: game_details, game: game)
        handle_release_associations(game_details, release)
        handle_publication_associations(game_details, publication)
      end
    end

    def handle_game(game_details)
      game = game_repo.find_by(title: game_details['title'])

      if game
        update_game.call(game_details: game_details, game: game)
      else
        create_game.call(game_details: game_details)
      end
    end

    def handle_release(game_details, game, platform)
      release = release_repo.find(game_details['release_id'])

      if release
        update_release.call(game_details: game_details, game: game, platform: platform, release: release)
      else
        create_release.call(game_details: game_details, game: game, platform: platform)
      end
    end

    def handle_publication(game_details, release)
      publication = publication_repo.find_by(gameopedia_id: game_details['public_id'])

      if publication
        update_publication.call(game_details: game_details, publication: publication, release: release)
      else
        create_publication.call(game_details: game_details, release: release)
      end
    end

    def handle_release_associations(game_details, release) # rubocop:disable Metrics/AbcSize
      create_ratings.call(game_details: game_details, release: release)
      create_developers.call(game_details: game_details, release: release)
      create_reviews.call(game_details: game_details, release: release)
      create_alternative_titles.call(game_details: game_details, release: release)
      create_videos.call(game_details: game_details, release: release)
      create_links.call(game_details: game_details, release: release)
      create_screenshots.call(game_details: game_details, release: release)
      create_covers.call(game_details: game_details, release: release)
      create_classifications.call(game_details: game_details, release: release)
      create_tech_specs.call(game_details: game_details, release: release)
    end

    def handle_publication_associations(game_details, publication)
      create_regions.call(game_details: game_details, publication: publication)
      create_publishers.call(game_details: game_details, publication: publication)
      create_descriptions.call(game_details: game_details, publication: publication)
      create_key_features.call(game_details: game_details, publication: publication)
    end
  end
end
