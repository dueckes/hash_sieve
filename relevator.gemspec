Gem::Specification.new do |s|
  s.name            = 'relevator'
  s.version         = '0.0.1'
  s.date            = '2015-12-18'
  s.homepage        = 'http://rubygems.org/gems/relevator'
  s.license         = 'MIT'
  s.summary         = ""
  s.description     = "Adapts enumerable objects to the same pattern as a reference object"
  s.authors         = ["Andrew King", "Matthew Ueckerman"]
  s.email           = 'andrew.king@myob.com'

  s.files           = Dir.glob("./lib/**/*")
  s.test_files      = Dir.glob("./spec/**/*")
  s.require_paths   = ["lib"]

  s.add_dependency "rake",          "~> 10.4"
  s.add_dependency 'activesupport', '~> 4.2'

  s.add_development_dependency "rspec",     "~> 3.3"
  s.add_development_dependency "simplecov", "~> 0.10"
  s.add_development_dependency "metric_fu",   "~> 4.11"
end
