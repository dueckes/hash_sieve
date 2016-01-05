module Relevator

  class AttributeParser

    class << self

      def parse(expected_data)
        parse_method = parse_methods_for(expected_data).find do |method|
          self.respond_to?(method, true)
        end
        parse_method ? self.send(parse_method, expected_data) : {}
      end

      private

      def parse_array_attributes(expected_data)
        expected_data.reduce({}) do |relevant_attributes, expected_value|
          parse(expected_value).each do |candidate_key, candidate_value|
            has_no_candidate_key = relevant_attributes[candidate_key].nil?
            if !candidate_value.empty? || has_no_candidate_key
              relevant_attributes[candidate_key] = candidate_value
            end
          end
          relevant_attributes
        end
      end

      alias_method :parse_set_attributes, :parse_array_attributes

      def parse_hash_attributes(expected_data)
        expected_data.reduce({}) do |relevant_attributes, expected_entry|
          expected_key, expected_value = expected_entry
          relevant_attributes[expected_key] = parse(expected_value)
          relevant_attributes
        end
      end

      def parse_methods_for(expected_data)
        class_heirarchy_of(expected_data.class).map do |candidate_class|
          "parse_#{candidate_class.name.underscore.downcase}_attributes".to_sym
        end
      end

      def class_heirarchy_of(a_class)
        a_class ? [ a_class ] + class_heirarchy_of(a_class.superclass) : []
      end

    end

  end

end
