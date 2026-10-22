#!/usr/bin/env rake
require 'bundler/gem_tasks'
require File.expand_path('../lib/chosen-dartsass/source_file', __FILE__)
require 'rake/testtask'

Rake::TestTask.new do |task|
  task.libs << 'test'
  task.pattern = 'test/**/*_test.rb'
end

task default: :test

desc "Update with the chosen-jjj library"
task 'update-chosen', 'repository_url', 'branch' do |task, args|
  remote = args['repository_url'] || 'https://github.com/JJJ/chosen'
  branch = args['branch'] || 'master'
  files = SourceFile.new
  files.fetch remote, branch
  files.cleanup
end
