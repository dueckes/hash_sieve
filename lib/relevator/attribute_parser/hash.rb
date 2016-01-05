module Relevator
  module AttributeParser

    class Hash

      def self.parse(hash)
        hash.reduce({}) do |attributes, entry|
          key, value = entry
          attributes[key] = Relevator::AttributeParser.parse(value)
          attributes
        end
      end

    end

  end
end
