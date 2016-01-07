require 'active_support/core_ext/string/inflections'

require 'hash_sieve/template_extractor/array'
require 'hash_sieve/template_extractor/set'
require 'hash_sieve/template_extractor/hash'
require 'hash_sieve/template_extractor'
require 'hash_sieve/sieve'

module HashSieve

  def self.strain(actual_data, template_args)
    HashSieve::Sieve.new(template_args[:template]).strain(actual_data)
  end

end
