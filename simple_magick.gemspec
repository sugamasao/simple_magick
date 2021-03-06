# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_magick/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_magick"
  spec.version       = SimpleMagick::VERSION
  spec.authors       = ["sugamasao"]
  spec.email         = ["sugamasao@gmail.com"]
  spec.summary       = %q{Simple ImageMagick Wrapper.}
  spec.description   = %q{Simple ImageMagick Wrapper.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "codeclimate-test-reporter"
end
