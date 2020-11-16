# frozen_string_literal: true

require 'gameopedia'

Gameopedia.configure do |config|
  config.auth_logon = ENV['GAMEOPEDIA_AUTH_LOGON']
  config.auth_key = ENV['GAMEOPEDIA_AUTH_KEY']
end
