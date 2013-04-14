# -*- ruby -*-
# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xes/version'

Gem::Specification.new do |gem|
  gem.name          = "ruby-xes"
  gem.version       = XES::VERSION
  gem.authors       = ["Keita Yamaguchi"]
  gem.email         = ["keita.yamaguchi@gmail.com"]
  gem.description   = "ruby-xes is a library for generating XES event log."
  gem.summary       = "ruby-xes is a library for generating XES event log."
  gem.homepage      = "https://github.com/pione/ruby-xes"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bacon"
  gem.add_development_dependency "yard", "~> 0.8.5"
  gem.add_development_dependency "redcarpet"
end
