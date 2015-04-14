# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/puma/version'

Gem::Specification.new do |spec|
  spec.name = 'capistrano-puma-sic'
  spec.version = Capistrano::Puma::VERSION
  spec.authors = ['Florian Schwab']
  spec.email = ['florian.schwab@sic-software.com']
  spec.description = %q{Puma integration for Capistrano 3}
  spec.summary = %q{Puma integration for Capistrano}
  spec.homepage = 'https://github.com/SICSoftwareGmbH/capistrano-puma'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 1.9.3'

  spec.files = `git ls-files`.split($/)
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.4'
  spec.add_dependency 'puma' ,      '>= 2.6'
end