# -*- encoding: utf-8 -*-
require File.expand_path('../lib/espn_rb/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jonathan Jackson"]
  gem.email         = ["jonj@promedicalinc.com"]
  gem.description   = %q{A Ruby wrapper for ESPN's api.}
  gem.summary       = %q{A Ruby wrapper for ESPN's api.}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "espn_rb"
  gem.require_paths = ["lib"]
  gem.version       = EspnRb::VERSION
end