module HashSieve
  module TemplateExtractor

    class Hash

      def self.extract(hash)
        hash.reduce({}) do |attributes, entry|
          key, value = entry
          attributes[key] = HashSieve::TemplateExtractor.extract(value)
          attributes
        end
      end

    end

  end
end
