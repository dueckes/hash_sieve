describe Relevator::TemplateExtractor do

  describe "::extract" do

    subject { described_class.extract(data) }

    { Array => Relevator::TemplateExtractor::Array,
      Set   => Relevator::TemplateExtractor::Set,
      Hash  => Relevator::TemplateExtractor::Hash }.each do |data_type, extractor|

      context "when provided data that is a #{data_type.name}" do

        let(:data) { data_type.new }

        it "extracts the attribute template using the extractor for that type" do
          expect(extractor).to receive(:extract).with(data)

          subject
        end

        it "returns the response from the extractor" do
          extract_response = { :key => "value" }
          allow(extractor).to receive(:extract).and_return(extract_response)

          expect(subject).to eql(extract_response)
        end

      end

    end

    context "when provided data that is another type" do

      let(:data) { "another type" }

      it "returns an empty hash" do
        expect(subject).to eql({})
      end

    end

  end

end
