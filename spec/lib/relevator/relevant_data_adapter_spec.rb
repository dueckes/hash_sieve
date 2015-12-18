require 'spec_helper'

RSpec.describe Relevator::RelevantDataAdapter do

  context '#initialize' do

    let(:expected_data) { {} }

    it 'should create a representation of attributes' do
      expect(Relevator::RelevantAttributesParser).to(
        receive(:parse).with(expected_data)
      )
      described_class.new(expected_data)
    end

  end

  context '#adapt' do

    context 'with no relevant attributes' do

      before(:each) do
        allow(Relevator::RelevantAttributesParser).to(
          receive(:parse).and_return({})
        )
      end

      let(:expected_data) { {} }
      let(:adapter) do
        described_class.new(expected_data)
      end

    end

  end

end
