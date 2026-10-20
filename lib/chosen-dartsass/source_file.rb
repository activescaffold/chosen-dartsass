require 'thor'
require 'json'

class SourceFile < Thor
  include Thor::Actions

  desc 'fetch source files', 'fetch source files from GitHub'
  def fetch remote, branch
    say "get from #{remote}/raw/#{branch}"
    get "#{remote}/raw/#{branch}/sass/chosen.scss", 'vendor/assets/stylesheets/chosen.scss', force: true
    get "#{remote}/raw/#{branch}/dist/js/chosen.jquery.js", 'vendor/assets/javascripts/chosen-jquery.js', force: true
    get "#{remote}/raw/#{branch}/dist/js/chosen.proto.js", 'vendor/assets/javascripts/chosen-prototype.js', force: true
    get "#{remote}/raw/#{branch}/package.json", 'lib/assets/javascripts/package.json', force: true
    bump_version
  end

  desc 'clean up useless files', 'clean up useless files'
  def cleanup
    self.destination_root = 'lib/assets/javascripts'
    remove_file 'package.json'
  end

  no_commands do
    def bump_version
      inside destination_root do
        package_json = JSON.load(File.open('lib/assets/javascripts/package.json'))
        version = package_json['version']
        gsub_file 'lib/chosen-dartsass/version.rb', /CHOSEN_VERSION\s=\s'(\d|\.)+'$/ do
          %Q{CHOSEN_VERSION = '#{version}'}
        end
      end
    end
  end
end
