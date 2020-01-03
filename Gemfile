# frozen_string_literal: true

source 'https://rubygems.org'

gem 'hanami', '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'rake'

gem 'pg'

gem 'dry-system'
gem 'dry-system-hanami', github: 'davydovanton/dry-system-hanami'
gem 'puma'
gem 'rubocop', require: false
gem 'scrypt'
gem 'warden'

group :plugins do
  gem 'hanami-reloader', git: 'https://github.com/DangerDawson/hanami-reloader'
end

group :development do
  gem 'guard'
  gem 'guard-process'
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
  gem 'pry', '~> 0.12.2'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '~> 1.7'
  gem 'factory_bot', '~> 5.1', '>= 5.1.1'
  gem 'faker', '~> 2.5'
  gem 'rspec'
  gem 'rubocop-rspec', require: false
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
end
