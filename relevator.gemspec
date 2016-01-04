# -*- encoding: utf-8 -*-
$:.push ::File.expand_path("../lib", __FILE__)
require "relevator/version"

Gem::Specification.new do |spec|
  spec.name        = "relevator"
  spec.version     = Relevator::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = [ "Andrew King", "Matthew Ueckerman" ]
  spec.summary     = "Adapts enumerable objects to the same pattern as a reference object"
  spec.description = "Adapts enumerable objects to the same pattern as a reference object"
  spec.email       = "andrew.king@myob.com"
  spec.homepage    = "http://github.com/MYOB-Technology/relevator"
  spec.license     = "MIT"

  spec.files      = Dir.glob("./lib/**/*")
  spec.test_files = Dir.glob("./spec/**/*")

  spec.require_path = "lib"

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_dependency "rake",          "~> 10.4"
  spec.add_dependency "activesupport", "~> 4.2"

  spec.add_development_dependency "travis-lint",               "~> 2.0"
  spec.add_development_dependency "rspec",                     "~> 3.4"
  spec.add_development_dependency "simplecov",                 "~> 0.11"
  spec.add_development_dependency "metric_fu",                 "~> 4.12"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.4"
end
