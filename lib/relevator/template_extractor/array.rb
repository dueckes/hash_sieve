module Relevator
  module TemplateExtractor

    class Array

      def self.extract(array)
        array.reduce({}) do |attributes, element|
          Relevator::TemplateExtractor.extract(element).each do |candidate_key, candidate_value|
            has_no_candidate_key = attributes[candidate_key].nil?
            attributes[candidate_key] = candidate_value if !candidate_value.empty? || has_no_candidate_key
          end
          attributes
        end
      end

    end

  end
end
