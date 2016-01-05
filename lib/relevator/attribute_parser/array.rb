module Relevator
  module AttributeParser

    class Array

      def self.parse(array)
        array.reduce({}) do |attributes, element|
          Relevator::AttributeParser.parse(element).each do |candidate_key, candidate_value|
            has_no_candidate_key = attributes[candidate_key].nil?
            attributes[candidate_key] = candidate_value if !candidate_value.empty? || has_no_candidate_key
          end
          attributes
        end
      end

    end

  end
end
