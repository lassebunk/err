# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'err/version'

Gem::Specification.new do |s|
  s.name          = "err"
  s.version       = Err::VERSION
  s.authors       = ["Lasse Bunk"]
  s.email         = ["lasse@bunk.io"]
  s.summary       = %q{Switch out error notification apps like MultiJSON.}
  s.description   = %q{Err lets you switch out error notification apps in a similar way to MultiJSON's parsers.}
  s.homepage      = "https://github.com/lassebunk/err"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^test/})
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.6"
  s.add_development_dependency "rake"

  # Services
  s.add_development_dependency "airbrake"
  s.add_development_dependency "opbeat"
end
