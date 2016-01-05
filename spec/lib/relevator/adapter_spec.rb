describe Relevator::Adapter do

  let(:target_data) { {} }

  let(:adapter) { described_class.new(target_data) }

  describe "constructor" do

    it "parsers a view of the attributes within the target data" do
      expect(Relevator::Parser).to receive(:parse).with(target_data)

      adapter
    end

  end

  context "#adapt" do

    subject { adapter.adapt(actual_data) }

    before(:each) { allow(Relevator::Parser).to receive(:parse).and_return(relevant_attributes) }

    context "when the target data structure has no relevant attributes" do

      let(:relevant_attributes) { {} }

      context "and an array of actual data is provided" do

        let(:actual_data) { %w{ first second third } }

        it "returns the actual data" do
          expect(subject).to eql(actual_data)
        end

      end

      context "and a set of actual data is provided" do

        let(:actual_data) { Set.new(%w{ first second third }) }

        it "returns the actual data" do
          expect(subject).to eql(actual_data)
        end

      end

      context "and a hash of actual data is provided" do

        let(:actual_data) { { key_1: "value_1", key_2: "value_2", key_3:  "value_3" } }

        it "returns an empty hash" do
          expect(subject).to eql({})
        end

      end

      [ 1, "two", Object.new ].each do |data|

        context "and actual data of type #{data.class.name.underscore.downcase} is provided" do

          let(:actual_data) { data }

          it "returns the actual data" do
            expect(subject).to eql(actual_data)
          end

        end

      end

    end

    context "when the target data structure has relevant attributes" do

      context "that are shallow" do

        let(:relevant_attributes) { { :key => {}, :another_key => {} } }

        context "and a hash of actual data whose attributes exactly match the relevant attributes is provided" do

          let(:actual_data) do
            {
              :key         => "value",
              :another_key => "another value"
            }
          end

          it "returns the actual data" do
            expect(subject).to eql(actual_data)
          end

        end

        context "and a hash of data whose attributes are a superset of the relevant attributes is provided" do

          let(:actual_data) do
            {
              :key             => "value",
              :another_key     => "another value",
              :yet_another_key => "yet another value"
            }
          end

          it "returns a hash containing only those attributes and values that are relevant" do
            expected_data = {
              :key         => "value",
              :another_key => "another value"
            }

            expect(subject).to eql(expected_data)
          end

        end

      end

      context "that are nested" do

        let(:relevant_attributes) { { :key => { :nested_key => {}, :another_nested_key => {} } } }

        context "when the nested types match" do

          let(:actual_data) do
            {
              :key =>         { :nested_key => [ 1, 2, 3 ], :another_nested_key => Set.new([ 4, 5, 6 ]) },
              :another_key => "another value"
            }
          end

          it "returns the relevant attributes" do
            expected_data = {
              :key => { :nested_key => [ 1, 2, 3 ], :another_nested_key => Set.new([ 4, 5, 6 ]) }
            }

            expect(subject).to eql(expected_data)
          end

        end

        context "when the nested types do not match" do

          let(:actual_data) { { :key => "different type" } }

          it "returns the actual data" do
            expect(subject).to eql(actual_data)
          end

        end

      end

    end

  end

end
