module Relevator
  module Parser

    class Hash

      def self.parse(hash)
        hash.reduce({}) do |attributes, entry|
          key, value = entry
          attributes[key] = Relevator::Parser.parse(value)
          attributes
        end
      end

    end

  end
end
