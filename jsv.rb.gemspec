# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jsv/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Yip"]
  gem.email         = ["yipdw@member.fsf.org"]
  gem.description   = %q{Provides access to JSV, a JSON Schema validator, from Ruby}
  gem.summary       = %q{Run JSV in Ruby applications}
  gem.homepage      = "https://github.com/NUBIC/jsv.rb"

  all_versioned     = `git ls-files`.split($\)

  gem.files         = all_versioned.grep(%r{^(lib|bin|spec)})
  gem.files        += ["js/build/jsv.rb.js"]
  gem.files        += Dir["{README,LICENSE}"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jsv.rb"
  gem.require_paths = ["lib"]
  gem.version       = JSV::VERSION

  gem.add_dependency 'execjs'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'travis-lint'
end
