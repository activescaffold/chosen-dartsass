# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chosen-dartsass/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Sergio Cambra']
  gem.email         = ['activescaffold@googlegroups.com']
  gem.description   = %q{Chosen is a javascript library of select box enhancer for jQuery and Protoype. This gem integrates Chosen with Rails asset pipeline using dartsass for easy of use, supporting propshaft.}
  gem.summary       = %q{Integrate Chosen javascript library with Rails asset pipeline}
  gem.homepage      = 'https://github.com/activescaffold/chosen-dartsass'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'chosen-dartsass'
  gem.require_paths = ['lib']
  gem.version       = Chosen::Dartsass::VERSION
  gem.license       = 'MIT'

  gem.add_dependency 'railties', '>= 3.0'
  gem.add_dependency 'dartsass-rails', '>= 0.5.0'

  gem.add_development_dependency 'bundler', '>= 1.0'
  gem.add_development_dependency 'rails', '>= 7.0'
  gem.add_development_dependency 'thor', '>= 0.14'
  gem.add_development_dependency 'coffee-rails', '>= 3.2'
end
