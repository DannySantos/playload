# frozen_string_literal: true

require_relative 'boot'

env = ENV['RACK_ENV'] || ENV['HANAMI_ENV'] || 'development'
Dotenv.load('.env', ".env.#{env}")

rackup      DefaultRackup
port        ENV['PORT']
environment env
