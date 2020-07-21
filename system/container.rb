# frozen_string_literal: true

require 'dry/system/container'
require 'dry/system/hanami'

class Container < Dry::System::Container
  extend Dry::System::Hanami::Resolver

  use :env

  register_folder! 'playload/entities'
  register_folder! 'playload/mailers'
  register_folder! 'playload/repositories'
  register_folder! 'playload/interactors'
  register_folder! 'playload/parser/helpers'

  register_file! 'playload/helpers/build_uuid'

  configure do |config|
    config.env = Hanami.env
  end
end
