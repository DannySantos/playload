# frozen_string_literal: true

require 'dotenv'

env = ENV['RACK_ENV'] || ENV['HANAMI_ENV'] || 'development'
Dotenv.load('.env', ".env.#{env}")

workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']
environment env

on_worker_boot do
  Hanami.boot
end
