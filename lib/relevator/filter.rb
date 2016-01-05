module Relevator

  class Filter

    def initialize(target_data)
      @attribute_template = Relevator::TemplateExtractor.extract(target_data)
    end

    def filter(actual_data)
      filter_value(actual_data, @attribute_template)
    end

    private

    def filter_value(value, attribute_template)
      if attribute_template
        class_name = value.class.name.underscore.downcase
        filter_method = "filter_#{class_name}_value".to_sym
        self.respond_to?(filter_method, true) ? self.send(filter_method, value, attribute_template) : value
      else
        nil
      end
    end

    def filter_array_value(value, attribute_template)
      value.map { |entry| filter_value(entry, attribute_template) }
    end

    def filter_set_value(value, attribute_template)
      Set.new(filter_array_value(value, attribute_template))
    end

    def filter_hash_value(value, attribute_template)
      value.reduce({}) do |filtered_hash, entry|
        key, value = entry
        filtered_hash[key] = filter_value(value, attribute_template[key]) if attribute_template.include?(key)
        filtered_hash
      end
    end

  end

end
