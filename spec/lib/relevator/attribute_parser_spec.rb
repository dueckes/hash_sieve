describe Relevator::AttributeParser do

  describe "::parse" do

    subject { described_class.parse(data) }

    context "when provided an array" do

      let(:data) { [] }

      it "returns a hash" do
        expect(subject).to be_a(Hash)
      end

      context "containing strings" do

        let(:data) { %w{ thing_one thing_two thing_three } }

        it "returns an empty hash" do
          expect(subject.empty?).to be(true)
        end

      end

      context "containing hashes" do

        context "that have identical attributes" do

          let(:data) do
            [
              { :id => 1, :name => "Travis" },
              { :id => 2, :name => "Tom"    },
              { :id => 3, :name => "Mark"   }
            ]
          end

          it "returns a hash containing all attributes" do
            expect(subject).to eql({ :id => {}, :name => {} })
          end

        end

        context "that have different attributes" do

          let(:data) do
            [
              { :id   => 1         },
              { :name => "Travis"  },
              { :type => "Drummer" }
            ]
          end

          it "should return a Hash of the all properties" do
            expect(subject).to eql({ :id => {}, :name => {}, :type => {} })
          end

        end

        context "that contains nested hashes" do

          let(:data) do
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

          it "returns a hash containing hashes for the nested attributes" do
            expect(subject).to eql({ :id => {}, :person => { :name => {}, :type => {} } })
          end

        end

      end

      context "containing arrays" do

        let(:data) do
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

    context "when provided a hash" do

      context "that contains simple attributes" do

        let(:data) do
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

      context "that contains nested attributes" do

        let(:data) do
          {
            :id     => 1,
            :person =>
              {
                :name => "Travis",
                :type => "Drummer"
              }
          }
        end

        it "returns a hash containing a hash with the nested attributes" do
          expect(subject).to eql({ :id => {}, :person => { :name => {}, :type => {} } })
        end

      end

    end

    context "when provided a value that is not enumerable" do

      let(:data) { "not enumerable" }

      it "returns an empty hash" do
        expect(subject).to eql({})
      end

    end

  end

end
