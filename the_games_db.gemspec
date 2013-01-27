# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "the_games_db/version"

Gem::Specification.new do |s|
  s.name        = "the_games_db"
  s.version     = TheGamesDB::VERSION
  s.authors     = ["Jared Pace"]
  s.email       = ["jared@codeword.io"]
  s.homepage    = "https://github.com/jdpace/the_games_db"
  s.summary     = %q{TheGamesDB.net API wrapper}
  s.description = %q{Ruby API Wrapper for TheGamesDB.net}

  s.rubyforge_project = "the_games_db"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Dependencies
  s.add_dependency 'typhoeus', ['~> 0.4.2']
  s.add_dependency 'nokogiri', ['~> 1.5.6']
  s.add_dependency 'sax-machine', ['~> 0.0.20']

  # Developmnet Dependencies
  s.add_development_dependency 'rake', ['~> 10.0']
  s.add_development_dependency 'rspec', ['~> 2.6']
  s.add_development_dependency 'mocha', ['~> 0.9.12']
  s.add_development_dependency 'guard-rspec', ['~> 0.4']
end
