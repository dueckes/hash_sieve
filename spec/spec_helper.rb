require 'bundler'
Bundler.require(:development)

CodeClimate::TestReporter.start

SimpleCov.start do
  add_filter "/spec/"
  minimum_coverage 100
  refuse_coverage_drop
end if ENV["coverage"]

require 'hash_sieve'
