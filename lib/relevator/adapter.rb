module Relevator

  class Adapter

    def initialize(target_data)
      @all_relevant_attributes = Relevator::Parser.parse(target_data)
    end

    def adapt(actual_data)
      adapt_value(actual_data, @all_relevant_attributes)
    end

    private

    def adapt_value(value, relevant_attributes)
      if relevant_attributes
        klass_name = value.class.name.underscore.downcase
        adapter_method = "adapt_#{klass_name}_value".to_sym
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

    def adapt_set_value(value, relevant_attributes)
      Set.new(adapt_array_value(value, relevant_attributes))
    end

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
