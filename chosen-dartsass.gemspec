# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chosen-dartsass/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Sergio Cambra']
  gem.email         = ['activescaffold@googlegroups.com']
  gem.description   = %q{Chosen is a JavaScript select-box enhancement library for jQuery and Prototype. This gem integrates Chosen with the Rails asset pipeline using Dart Sass, supporting both Propshaft and Sprockets.}
  gem.summary       = %q{Integrate Chosen javascript library with Rails asset pipeline}
  gem.homepage      = 'https://github.com/activescaffold/chosen-dartsass'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n").select { |file| File.file?(file) }
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'chosen-dartsass'
  gem.require_paths = ['lib']
  gem.version       = Chosen::Dartsass::VERSION
  gem.license       = 'MIT'

  gem.add_dependency 'railties', '>= 3.0'

  gem.add_development_dependency 'bundler', '>= 1.0'
  gem.add_development_dependency 'minitest', '>= 5.0'
  gem.add_development_dependency 'rails', '>= 7.0'
  gem.add_development_dependency 'rake', '>= 12.0'
  gem.add_development_dependency 'thor', '>= 0.14'
end
