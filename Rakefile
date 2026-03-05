#!/usr/bin/env rake
require 'bundler/gem_tasks'
require File.expand_path('../lib/chosen-dartsass/source_file', __FILE__)

desc "Update with Harvest's Chosen Library"
task 'update-chosen', 'repository_url', 'branch' do |task, args|
  remote = args['repository_url'] || 'https://github.com/harvesthq/chosen'
  branch = args['branch'] || 'main'
  files = SourceFile.new
  #files.fetch remote, branch
  #files.eject_javascript_class_from_closure
  files.generate_js
  files.cleanup
end
