# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'katsuyoujin/version'

Gem::Specification.new do |spec|
  spec.name          = 'katsuyoujin'
  spec.version       = Katsuyoujin::VERSION
  spec.authors       = ['LuckyThirteen']
  spec.email         = ['baloghzsof@gmail.com']
  spec.summary       = 'Japanese verb conjugator.'
  spec.description   = ''
  spec.homepage      = 'https://github.com/LuckyThirteen/katsuyoujin'
  spec.license       = 'GPLv3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'mojinizer'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov-gem-profile'
  spec.add_development_dependency 'rubycritic'
  spec.add_development_dependency 'coveralls'
end
