# frozen_string_literal: true

require 'minitest/autorun'
require 'rails'

if Gem.loaded_specs.key?('dartsass-sprockets')
  require 'sprockets/railtie'
  require 'dartsass-sprockets'
else
  require 'propshaft'
  require 'propshaft/railtie'
  require 'dartsass-rails'
  require 'sass-embedded'
end

require 'chosen-dartsass'

class DummyApplication < Rails::Application
  config.root = File.expand_path('dummy', __dir__)
  config.eager_load = false
  config.secret_key_base = 'chosen-dartsass-test-secret-key-base'
  config.logger = Logger.new(nil)
end

DummyApplication.initialize!
