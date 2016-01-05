describe Relevator::DataAdapter do

  describe "constructor" do

    let(:expected_data) { {} }
    let(:adapter) { described_class.new(expected_data) }

    it "creates a view of the attributes within the expected data" do
      expect(Relevator::AttributeParser).to receive(:parse).with(expected_data)

      adapter
    end

  end

  context "#adapt" do

    context "when the expected data structure has no relevant attributes" do

      let(:expected_data) { {} }
      let(:adapter) do
        described_class.new(expected_data)
      end

      before(:each) do
        allow(Relevator::RelevantAttributesParser).to(
          receive(:parse).and_return({})
        )
      end

      context 'with an array value' do

        it 'should return an array of the values' do
          raw_data = %w{one two three}
          expect(adapter.adapt(raw_data)).to eq(raw_data)
        end

      end

      context 'with a set value' do

        it 'should return an array of the values' do
          raw_data = %w{one two three}
          expect(adapter.adapt(Set.new(raw_data))).to eq(raw_data)
        end

      end

      context 'with a hash value' do

        it 'should return an empty hash' do
          raw_data = {
            one:    1,
            two:    2,
            three:  3
          }
          expect(adapter.adapt(raw_data)).to eq(expected_data)
        end

      end

      [1, 'two', Object.new].each do |raw_value|
        context "with a #{raw_value.class.name.underscore.downcase} value" do

          it 'should return the value' do
            expect(adapter.adapt(raw_value)).to eq(raw_value)
          end

        end
      end

    end

    context 'when the expected data structure has relevant attributes' do

      context 'with an array value' do

        let(:expected_data) { [9, 0, 2, 1, 0] }
        let(:adapter) do
          described_class.new(expected_data)
        end
        before(:each) do
          allow(Relevator::RelevantAttributesParser).to(
            receive(:parse).and_return({})
          )
        end

        it 'should return the array of values' do
          raw_value = [9, 0, 2, 1, 0]
          expect(adapter.adapt(raw_value)).to eq(expected_data)
        end

      end

      context 'with a set value' do

        let(:expected_data) { [9, 0, 2, 1] }
        let(:adapter) do
          described_class.new(expected_data)
        end
        before(:each) do
          allow(Relevator::RelevantAttributesParser).to(
            receive(:parse).and_return({})
          )
        end

        it 'should return the array of values' do
          raw_value = Set.new([9, 0, 2, 1, 0])
          expect(adapter.adapt(raw_value)).to eq(expected_data)
        end

      end

      context 'with a hash value' do

        let(:adapter) do
          described_class.new({
            :exists         => 'dragons',
            :also_exists    => 'owls'
          })
        end
        before(:each) do
          allow(Relevator::RelevantAttributesParser).to(
            receive(:parse).and_return({:exists => {}})
          )
        end

        it 'should return the filtered attributes' do
          raw_value = {
            :exists       => 'dragons',
            :not_exists   => 'goblins'
          }
          expect(adapter.adapt(raw_value)).to eq({
            :exists => 'dragons'
          })
        end

      end

      context 'with a complex object' do

        context "when the nested types don't match" do

          let(:adapter) do
            described_class.new({
              :product    => {
                :type       => 'beverage',
                :name       => 'milkshake'
              }
            })
          end
          let(:raw_value) do
            {
              :product   => 'non-existent'
            }
          end
          let(:expected_data) do
            {
              :product   => 'non-existent'
            }
          end
          before(:each) do
            allow(Relevator::RelevantAttributesParser).to(
              receive(:parse).and_return({
                :product => {
                  :type   => {},
                  :name   => {}
                }
              })
            )
          end

          it 'should return the raw value' do
            expect(adapter.adapt(raw_value)).to eq(expected_data)
          end

        end

        context "when the nested types match" do

          let(:adapter) do
            described_class.new({
              :flavours   => [
                'chocolate',
                'coffee',
                'chai'
              ],
              :product    => {
                :type       => 'beverage',
                :name       => 'milkshake'
              }
            })
          end
          let(:raw_value) do
            {
              :flavours   => [
                'bbq'
              ],
              :product    => {
                :name       => 'chips',
                :brand      => 'MegaChips'
              }
            }
          end
          let(:expected_data) do
            {
              :flavours   => [
                'bbq'
              ],
              :product    => {
                :name       => 'chips'
              }
            }
          end
          before(:each) do
            allow(Relevator::RelevantAttributesParser).to(
              receive(:parse).and_return({
                :flavours => {},
                :product  => {
                  :type     => {},
                  :name     => {}
                }
              })
            )
          end

          it 'should return the filtered attributes' do
            expect(adapter.adapt(raw_value)).to eq(expected_data)
          end

        end

      end

      class ArbitraryObject < Object; end

      [1, 'two', ArbitraryObject.new].each do |raw_value|
        context "with a #{raw_value.class.name.underscore.downcase} value" do

          let(:adapter) do
            described_class.new({:one => 'two'})
          end
          before(:each) do
            allow(Relevator::RelevantAttributesParser).to(
              receive(:parse).and_return({
                :one => {}
              })
            )
          end

          it 'should return the value' do
            expect(adapter.adapt(raw_value)).to eq(raw_value)
          end

        end

      end

    end

  end

end
