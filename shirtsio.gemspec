# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shirtsio/version'

Gem::Specification.new do |spec|
  spec.name          = "shirtsio"
  spec.version       = Shirtsio::VERSION
  spec.authors       = ["Anthony Smith"]
  spec.email         = ["anthony@sticksnleaves.com"]
  spec.description   = %q{A shirts.io API wrapper written in Ruby}
  spec.summary       = %q{shirts.io REST API client library for Ruby}
  spec.homepage      = "https://github.com/anthonator/shirtsio"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "faraday",    "~> 0.8"
  spec.add_dependency "hashie",     "~> 2.0"
  spec.add_dependency "multi_json", "~> 1.8"
end
