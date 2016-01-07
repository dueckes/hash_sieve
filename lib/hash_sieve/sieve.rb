module HashSieve

  class Sieve

    def initialize(target_data)
      @attribute_template = HashSieve::TemplateExtractor.extract(target_data)
    end

    def strain(actual_data)
      strain_value(actual_data, @attribute_template)
    end

    private

    def strain_value(value, attribute_template)
      if attribute_template
        class_name = value.class.name.underscore.downcase
        strain_method = "strain_#{class_name}_value".to_sym
        self.respond_to?(strain_method, true) ? self.send(strain_method, value, attribute_template) : value
      else
        nil
      end
    end

    def strain_array_value(value, attribute_template)
      value.map { |entry| strain_value(entry, attribute_template) }
    end

    def strain_set_value(value, attribute_template)
      Set.new(strain_array_value(value, attribute_template))
    end

    def strain_hash_value(value, attribute_template)
      value.reduce({}) do |strained_hash, entry|
        key, value = entry
        strained_hash[key] = strain_value(value, attribute_template[key]) if attribute_template.include?(key)
        strained_hash
      end
    end

  end

end
