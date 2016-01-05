describe Relevator::Parser::Hash do

  describe "::parse" do

    let(:hash) { {} }

    subject { described_class.parse(hash) }

    it "returns a hash" do
      expect(subject).to be_a(Hash)
    end

    context "when provided a hash with simple attributes" do

      let(:hash) do
        {
          :id   => 1,
          :name => "Peter",
          :type => "Drummer"
        }
      end

      it "returns a hash containing the attributes" do
        expect(subject).to eql({ :id => {}, :name => {}, :type => {} })
      end

    end

    context "when provided a hash with nested hashes" do

      let(:hash) do
        {
          :id     => 1,
          :person =>
            {
              :name => "Travis",
              :type => "Drummer"
            }
        }
      end

      it "returns a hash containing hashes with nested attributes" do
        expect(subject).to eql({ :id => {}, :person => { :name => {}, :type => {} } })
      end

    end

    context "when provided a hash with nested arrays" do

      let(:hash) do
        {
          :name => "Orchestra",
          :instruments => [
            { :name => "Drum" },
            { :name => "Guitar", type: "Bass" },
            { :name => "Violin" }
          ]
        }
      end

      it "returns a hash containing a hash with attributes in the nested array" do
        expect(subject).to eql({ :name => {}, :instruments => { :name => {}, :type => {} } })
      end

    end

  end

end
