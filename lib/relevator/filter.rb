module Relevator

  class Filter

    def initialize(target_data)
      @all_relevant_attributes = Relevator::AttributeParser.parse(target_data)
    end

    def filter(actual_data)
      filter_value(actual_data, @all_relevant_attributes)
    end

    private

    def filter_value(value, relevant_attributes)
      if relevant_attributes
        class_name = value.class.name.underscore.downcase
        filter_method = "filter_#{class_name}_value".to_sym
        self.respond_to?(filter_method, true) ? self.send(filter_method, value, relevant_attributes) : value
      else
        nil
      end
    end

    def filter_array_value(value, relevant_attributes)
      value.map { |entry| filter_value(entry, relevant_attributes) }
    end

    def filter_set_value(value, relevant_attributes)
      Set.new(filter_array_value(value, relevant_attributes))
    end

    def filter_hash_value(value, relevant_attributes)
      value.reduce({}) do |filtered_hash, entry|
        key, value = entry
        filtered_hash[key] = filter_value(value, relevant_attributes[key]) if relevant_attributes.include?(key)
        filtered_hash
      end
    end

  end

end
