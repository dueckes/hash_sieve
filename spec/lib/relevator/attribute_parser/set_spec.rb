describe Relevator::AttributeParser::Set do

  it "is identical to the array parser" do
    expect(described_class).to eql(Relevator::AttributeParser::Array)
  end

  describe "::parse" do

    let(:set) { ::Set.new }

    subject { described_class.parse(set) }

    it "returns a hash" do
      expect(subject).to be_a(Hash)
    end

    context "when provided an array of hashes" do

      let(:set) do
        ::Set.new(
          [
            { :id => 1, :name => "Travis" },
            { :id => 2, :name => "Tom"    },
            { :id => 3, :name => "Mark"   }
          ]
        )
      end

      it "returns a hash containing all of the attributes" do
        expect(subject).to eql({ :id => {}, :name => {} })
      end

    end

  end

end
