describe HashSieve do

  describe "::strain" do

    let(:actual_data)   { { actual_key:   "value" } }
    let(:strained_data) { { strained_key: "value" } }
    let(:sieve)         { instance_double(HashSieve::Sieve, strain: strained_data) }

    let(:template_data) { { template_key: "value" } }

    before(:example) { allow(HashSieve::Sieve).to receive(:new).and_return(sieve) }

    subject { described_class.strain(actual_data, template: template_data) }

    it "creates a sieve for the template data" do
      expect(HashSieve::Sieve).to receive(:new).with(template_data)

      subject
    end

    it "strains the actual data through the sieve" do
      expect(sieve).to receive(:strain).with(actual_data)

      subject
    end

    it "returns the strained data" do
      expect(subject).to eql(strained_data)
    end

  end

end
