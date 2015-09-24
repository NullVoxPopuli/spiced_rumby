# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spiced_gracken/version'

Gem::Specification.new do |s|
  s.name        = 'spiced_gracken'
  s.version     = SpicedGracken::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = 'MIT'
  s.authors     = ['L. Preston Sego III']
  s.email       = 'LPSego3+dev@gmail.com'
  s.homepage    = 'https://github.com/NullVoxPopuli/spiced_gracken'
  s.summary     = "SpicedGracken-#{SpicedGracken::VERSION}"
  s.description = 'A RUM Client in Ruby'


  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.0'

  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'colorize'


  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'codeclimate-test-reporter'

end
