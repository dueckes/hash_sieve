describe HashSieve do

  describe "::strain" do

    subject { described_class.strain(actual_data, template: template) }

    context "when provided a hash structure" do

      let(:template) do
        { needed: "" }
      end
      let(:actual_data) do
        {
          needed:     "important value",
          not_needed: "unimportant value"
        }
      end

      it "strains the structure" do
        expect(subject).to eql(needed: "important value")
      end

    end

    context "when provided an array structure" do

      let(:template) do
        [ { needed_array: [ { needed_string: "" } ] } ]
      end
      let(:actual_data) do
        [
          {
            needed_array: [
              {
                needed_string: "important value"
              }
            ],
            not_needed: "unimportant value"
          }
        ]
      end

      it "strains the structure" do
        expect(subject).to eql([ { needed_array: [ { needed_string: "important value" } ] } ])
      end

    end

  end

end
