# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'semantics/version'

Gem::Specification.new do |spec|
  spec.name          = 'semantics'
  spec.version       = Semantics::VERSION
  spec.authors       = ['verwec']
  spec.email         = ['sebastian@vertragswecker.de']

  spec.summary       = 'Simple ax_semantics services library'
  spec.homepage      = 'https://github.com/verwec/semantics'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_dependency 'json'
  spec.add_dependency 'httparty'
  spec.add_dependency 'dotenv'
end
