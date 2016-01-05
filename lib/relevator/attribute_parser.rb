module Relevator

  module AttributeParser

    class << self

      def parse(data)
        parser = parser_for(data)
        parser ? parser.parse(data) : {}
      end

      private

      def parser_for(data)
        parsers = class_hierarchy_of(data.class).map do |candidate_class|
          "Relevator::AttributeParser::#{candidate_class.name}".constantize rescue nil
        end
        parsers.empty? ? nil : parsers.first
      end

      def class_hierarchy_of(a_class)
        a_class ? [ a_class ] + class_hierarchy_of(a_class.superclass) : []
      end

    end

  end

end
