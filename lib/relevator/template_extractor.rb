module Relevator

  module TemplateExtractor

    class << self

      def extract(data)
        extractor = extractor_for(data)
        extractor ? extractor.extract(data) : {}
      end

      private

      def extractor_for(data)
        extractors = class_hierarchy_of(data.class).map do |candidate_class|
          "Relevator::TemplateExtractor::#{candidate_class.name}".constantize rescue nil
        end
        extractors.empty? ? nil : extractors.first
      end

      def class_hierarchy_of(a_class)
        a_class ? [ a_class ] + class_hierarchy_of(a_class.superclass) : []
      end

    end

  end

end
