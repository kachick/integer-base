# coding: us-ascii
# frozen_string_literal: true

lib_name = 'integer-base'

require File.expand_path('../lib/integer/base/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.summary       = %q{Any formats can mean positional/unary numeral systems}
  gem.description   = %q{Any formats can mean positional/unary numeral systems :)
So base number conversion under your choice.}

  gem.homepage      = "https://github.com/kachick/#{lib_name}"
  gem.license       = 'MIT'
  gem.name          = lib_name
  gem.version       = Integer::Base::VERSION

  gem.add_development_dependency 'test-unit', '>= 3.4.1', '< 4'
  gem.add_development_dependency 'yard', '>= 0.9.26', '< 2'
  gem.add_development_dependency 'rake', '>= 13.0.3', '< 20'
  
  gem.required_ruby_version = '>= 2.5'

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.files         = `git ls-files`.split($\)
  gem.require_paths = ['lib']
end
