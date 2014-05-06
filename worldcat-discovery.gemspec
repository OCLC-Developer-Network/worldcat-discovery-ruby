# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'worldcat/discovery/version'

Gem::Specification.new do |spec|
  spec.name          = "worldcat-discovery"
  spec.version       = Worldcat::Discovery::VERSION
  spec.authors       = ["OCLC Developer Network"]
  spec.email         = ["devnet@oclc.org"]
  spec.description   = %q{A Ruby wrapper for accessing the WorldCat Discovery API}
  spec.summary       = %q{Provides access to the WorldCat Discovery API, parsing the RDF data responses and returning Ruby objects. Requires an OCLC Web Service Key.}
  spec.homepage      = "http://oclc.org/developer"
  spec.license       = "Apache 2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  gem.add_development_dependency 'rspec', '~> 2.14', '>= 2.14.1'
  gem.add_development_dependency 'simplecov', '~> 0.8', '>= 0.8.2'
  gem.add_development_dependency 'webmock', '~> 1.16'
end
