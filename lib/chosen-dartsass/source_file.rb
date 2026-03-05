require 'thor'
require 'json'
require 'coffee-script'

class SourceFile < Thor
  include Thor::Actions

  desc 'fetch source files', 'fetch source files from GitHub'
  def fetch remote, branch
    say "get from #{remote}/raw/#{branch}"
    get "#{remote}/raw/#{branch}/public/chosen-sprite.png", 'vendor/assets/images/chosen-sprite.png'
    get "#{remote}/raw/#{branch}/public/chosen-sprite@2x.png", 'vendor/assets/images/chosen-sprite@2x.png'
    get "#{remote}/raw/#{branch}/sass/chosen.scss", 'vendor/assets/stylesheets/chosen.scss'
    get "#{remote}/raw/#{branch}/coffee/lib/abstract-chosen.coffee", 'lib/assets/javascripts/lib/abstract-chosen.coffee'
    get "#{remote}/raw/#{branch}/coffee/lib/select-parser.coffee", 'lib/assets/javascripts/lib/select-parser.coffee'
    get "#{remote}/raw/#{branch}/coffee/chosen.jquery.coffee", 'lib/assets/javascripts/chosen.jquery.coffee'
    get "#{remote}/raw/#{branch}/coffee/chosen.proto.coffee", 'lib/assets/javascripts/chosen.proto.coffee'
    get "#{remote}/raw/#{branch}/package.json", 'lib/assets/javascripts/package.json'
    bump_version
  end

  desc 'eject class from closure', 'eject javascript library class from closure'
  def eject_javascript_class_from_closure
    self.destination_root = 'lib/assets/javascripts'
    inside destination_root do
      append_to_file 'lib/abstract-chosen.coffee' do
        "\nwindow.AbstractChosen = AbstractChosen\n"
      end
      append_to_file 'lib/select-parser.coffee' do
        "\n\nwindow.SelectParser = SelectParser\n"
      end
    end
  end

  desc 'generate JS files', 'generate JS files from coffee script source'
  def generate_js
    gem_root = File.expand_path('../..', __dir__)
    coffee_dir = File.join(gem_root, 'lib', 'assets', 'javascripts')
    output_dir = File.join(gem_root, 'vendor', 'assets', 'javascripts')

    # Create output directory
    FileUtils.mkdir_p(output_dir)

    # Collect all CoffeeScript files to combine
    coffee_files = []
    
    # 1. First include your lib coffee scripts
    lib_files = [
      File.join(coffee_dir, 'lib/abstract-chosen.coffee'),
      File.join(coffee_dir, 'lib/select-parser.coffee'),
    ]
    coffee_files.concat(lib_files)

    {'chosen.jquery.coffee' => 'chosen-jquery.js', 'chosen.proto.coffee' => 'chosen-prototype.js'}.each do |coffee, js|
      say "Generating JS #{js} from #{coffee}"
      combined_coffee = [*coffee_files, File.join(coffee_dir, coffee)].map do |file|
        File.read(file)
      end.join("\n\n")
      output_file = File.join(output_dir, js)
      coffee2js(combined_coffee, output_file)
    end
  end

  desc 'clean up useless files', 'clean up useless files'
  def cleanup
    self.destination_root = 'lib/assets/javascripts'
    remove_file 'package.json'
  end

  protected

  def coffee2js(coffee, output_file)
    js_code = CoffeeScript.compile(coffee)
    File.write(output_file, js_code)
    
    say "✅ Successfully generated #{output_file}"
    say "   Size: #{File.size(output_file)} bytes"
    
  rescue => e
    say "❌ Failed to compile: #{e.message}"
    say e.backtrace.first(5).join("\n")
    exit 1
  end

  def bump_version
    inside destination_root do
      package_json = JSON.load(File.open('lib/assets/javascripts/package.json'))
      version = package_json['version']
      gsub_file 'lib/chosen-dartsass/version.rb', /CHOSEN_VERSION\s=\s'(\d|\.)+'$/ do |match|
        %Q{CHOSEN_VERSION = '#{version}'}
      end
    end
  end
end
