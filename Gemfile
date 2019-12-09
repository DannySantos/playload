source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'

gem 'pg'

group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
  gem 'pry', '~> 0.12.2'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'faker', '~> 2.5'
  gem 'database_cleaner', '~> 1.7'
  gem 'factory_bot', '~> 5.1', '>= 5.1.1'
end

group :production do
  # gem 'puma'
end
