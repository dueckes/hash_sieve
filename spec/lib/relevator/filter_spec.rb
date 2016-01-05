describe Relevator::Filter do

  let(:target_data) { {} }

  let(:filter) { described_class.new(target_data) }

  describe "constructor" do

    it "extracts a template of the attributes within the target data" do
      expect(Relevator::TemplateExtractor).to receive(:extract).with(target_data)

      filter
    end

  end

  context "#filter" do

    subject { filter.filter(actual_data) }

    before(:each) { allow(Relevator::TemplateExtractor).to receive(:extract).and_return(attribute_template) }

    context "when the template data structure has no attributes" do

      let(:attribute_template) { {} }

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

    context "when the target data structure has attributes" do

      context "that are shallow" do

        let(:attribute_template) { { :key => {}, :another_key => {} } }

        context "and a hash of actual data whose attributes exactly match the templated attributes is provided" do

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

        context "and a hash of data whose attributes are a superset of the templated attributes is provided" do

          let(:actual_data) do
            {
              :key             => "value",
              :another_key     => "another value",
              :yet_another_key => "yet another value"
            }
          end

          it "returns a hash containing only those attributes and values that are templated" do
            expected_data = {
              :key         => "value",
              :another_key => "another value"
            }

            expect(subject).to eql(expected_data)
          end

        end

      end

      context "that are nested" do

        let(:attribute_template) { { :key => { :nested_key => {}, :another_nested_key => {} } } }

        context "when the nested types match" do

          let(:actual_data) do
            {
              :key =>         { :nested_key => [ 1, 2, 3 ], :another_nested_key => Set.new([ 4, 5, 6 ]) },
              :another_key => "another value"
            }
          end

          it "returns the templated attributes" do
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
