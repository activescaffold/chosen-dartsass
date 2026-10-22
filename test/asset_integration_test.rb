# frozen_string_literal: true

require_relative 'test_helper'

class AssetIntegrationTest < Minitest::Test
  SASS_INTEGRATIONS = %w[dartsass-rails dartsass-sprockets].freeze
  STYLESHEET = 'chosen.scss'
  JAVASCRIPTS = %w[chosen-jquery.js chosen-prototype.js].freeze

  def test_sass_integration_is_selected_by_the_application
    selected_integrations = SASS_INTEGRATIONS.select { |name| Gem.loaded_specs.key?(name) }

    assert_equal 1, selected_integrations.size
  end

  def test_gem_does_not_force_a_sass_integration
    runtime_dependencies = Gem.loaded_specs.fetch('chosen-dartsass').runtime_dependencies.map(&:name)

    SASS_INTEGRATIONS.each { |name| refute_includes runtime_dependencies, name }
  end

  def test_engine_adds_vendor_assets_to_the_pipeline
    paths = Rails.application.config.assets.paths.map(&:to_s)

    assert_includes paths, Chosen::Dartsass::Engine.root.join('vendor/assets/stylesheets').to_s
    assert_includes paths, Chosen::Dartsass::Engine.root.join('vendor/assets/javascripts').to_s
  end

  def test_pipeline_finds_packaged_assets
    assert pipeline_asset(STYLESHEET)
    JAVASCRIPTS.each { |javascript| assert pipeline_asset(javascript) }
  end

  def test_selected_dart_sass_integration_compiles_the_stylesheet
    css =
      if Gem.loaded_specs.key?('dartsass-sprockets')
        Rails.application.assets.find_asset('chosen.css').to_s
      else
        Sass.compile_string(
          '@use "chosen";',
          load_paths: Rails.application.config.assets.paths.map(&:to_s)
        ).css
      end

    assert_includes css, '.chosen-container'
  end

  private

  def pipeline_asset(logical_path)
    if Gem.loaded_specs.key?('dartsass-sprockets')
      Rails.application.assets.find_asset(logical_path)
    else
      Rails.application.assets.load_path.find(logical_path)
    end
  end
end
