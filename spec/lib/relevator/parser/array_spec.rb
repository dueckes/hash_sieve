describe Relevator::Parser::Array do

  describe "::parse" do

    let(:array) { [] }

    subject { described_class.parse(array) }

    it "returns a hash" do
      expect(subject).to be_a(Hash)
    end

    context "when provided an array of strings" do

      let(:array) { %w{ thing_one thing_two thing_three } }

      it "returns an empty hash" do
        expect(subject.empty?).to be(true)
      end

    end

    context "when provided an array of hashes" do

      context "that have identical attributes" do

        let(:array) do
          [
            { :id => 1, :name => "Travis" },
            { :id => 2, :name => "Tom"    },
            { :id => 3, :name => "Mark"   }
          ]
        end

        it "returns a hash containing all of the attributes" do
          expect(subject).to eql({ :id => {}, :name => {} })
        end

      end

      context "that have different attributes" do

        let(:array) do
          [
            { :id   => 1         },
            { :name => "Travis"  },
            { :type => "Drummer" }
          ]
        end

        it "returns a hash combining attributes from all the hashes" do
          expect(subject).to eql({ :id => {}, :name => {}, :type => {} })
        end

      end

      context "that contains nested hashes" do

        let(:array) do
          [
            {
              :id     => 1,
              :person =>
                {
                  :name => "Travis",
                  :type => "Drummer"
                }
            },
            {
              :id     => 2,
              :person =>
                {
                  :name => "Tom",
                  :type => "Guitar"
                }
            },
            {
              :id     => 3,
              :person =>
                {
                  :name => "Mark",
                  :type => "Bass"
                }
            }
          ]
        end

        it "returns a hash containing hashes with the nested attributes" do
          expect(subject).to eql({ :id => {}, :person => { :name => {}, :type => {} } })
        end

      end

    end

    context "when provided an array of arrays" do

      let(:array) do
        [
          [ 1, 2, 3 ],
          [ :one, :two, :three ]
        ]
      end

      it "returns an empty hash" do
        expect(subject).to eql({})
      end

    end

  end

end
