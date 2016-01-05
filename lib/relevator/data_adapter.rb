module Relevator

  class DataAdapter

    def initialize(expected_data)
      @all_relevant_attributes = Relevator::AttributeParser.parse(expected_data)
    end

    def adapt(actual_data)
      adapt_value(actual_data, @all_relevant_attributes)
    end

    private

    def adapt_value(value, relevant_attributes)
      if relevant_attributes
        adapter_method = "adapt_#{value.class.name.underscore.downcase}_value".to_sym
        if self.respond_to?(adapter_method, true)
          self.send(adapter_method, value, relevant_attributes)
        else
          value
        end
      else
        nil
      end
    end

    def adapt_array_value(value, relevant_attributes)
      value.map { |entry| adapt_value(entry, relevant_attributes) }
    end

    alias_method :adapt_set_value, :adapt_array_value

    def adapt_hash_value(value, relevant_attributes)
      value.reduce({}) do |adapted_hash, entry|
        key, value = entry
        if relevant_attributes.include?(key)
          adapted_hash[key] = adapt_value(value, relevant_attributes[key])
        end
        adapted_hash
      end
    end

  end

end
