require 'bundler'
Bundler.require(:development)

SimpleCov.start do
  add_filter "/spec/"
  minimum_coverage 100
  refuse_coverage_drop
end if ENV["coverage"]

require 'relevator'
