require_relative './spec_helper'

require 'capybara'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include RSpec::FeatureExampleGroup

  config.include Capybara::DSL,           feature: true
  config.include Capybara::RSpecMatchers, feature: true

  Capybara.configure do |config|
    config.server = :webrick
    config.javascript_driver = :selenium_chrome_headless
    config.save_path = "#{Hanami.root}/tmp/screenshots"
    config.app = Playload
    config.automatic_label_click = true
    config.raise_server_errors = true
    config.default_max_wait_time = 5
    config.server_host = 'localhost'
    config.server_port = '2400'
  end
end
