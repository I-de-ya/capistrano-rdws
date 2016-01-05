# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/rdws/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-rdws'
  spec.version       = Capistrano::Rdws::VERSION
  spec.authors       = ['Rydkin Maxim']
  spec.email         = ['maks.rydkin@gmail.com']
  spec.description   = 'This gem is a bundle of capistrano 3 recipes used for RDWS projects'
  spec.summary       = ''
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'capistrano', '~> 3.1'
  spec.add_development_dependency 'capistrano-bundler', '~> 1.1'
end
