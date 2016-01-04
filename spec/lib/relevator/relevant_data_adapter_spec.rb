describe Relevator::RelevantDataAdapter do

  let(:expected_data) { {} }

  let(:adapter) { described_class.new(expected_data) }

  describe "constructor" do

    it "creates a view of the attributes within the expected data" do
      expect(Relevator::RelevantAttributesParser).to receive(:parse).with(expected_data)

      adapter
    end

  end

  context "#adapt" do

    let(:relevant_attributes) { {} }

    subject { adapter.adapt(actual_data) }

    before(:each) do
      allow(Relevator::RelevantAttributesParser).to receive(:parse).and_return(relevant_attributes)
    end

    context "when the expected data structure has no relevant attributes" do

      let(:relevant_attributes) { {} }

      context "and the actual data"

    end

  end

end
