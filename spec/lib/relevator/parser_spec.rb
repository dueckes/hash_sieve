describe Relevator::Parser do

  describe "::parse" do

    subject { described_class.parse(data) }

    { Array => Relevator::Parser::Array,
      Set   => Relevator::Parser::Set,
      Hash  => Relevator::Parser::Hash }.each do |data_type, parser|

      context "when provided data that is a #{data_type.name}" do

        let(:data) { data_type.new }

        it "parses the data using the parser for that type" do
          expect(parser).to receive(:parse).with(data)

          subject
        end

        it "returns the response from the parser" do
          parse_response = { :key => "value" }
          allow(parser).to receive(:parse).and_return(parse_response)

          expect(subject).to eql(parse_response)
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
