# frozen_string_literal: true

require_relative './spec_helper'

require 'capybara'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include RSpec::FeatureExampleGroup

  config.include Capybara::DSL,           feature: true
  config.include Capybara::RSpecMatchers, feature: true

  Capybara.configure do |capybara_config|
    capybara_config.server = :webrick
    capybara_config.javascript_driver = :selenium_chrome
    capybara_config.save_path = "#{Hanami.root}/tmp/screenshots"
    capybara_config.app = Playload
    capybara_config.automatic_label_click = true
    capybara_config.raise_server_errors = true
    capybara_config.default_max_wait_time = 5
    capybara_config.server_host = 'localhost'
    capybara_config.server_port = '2400'
  end
end
