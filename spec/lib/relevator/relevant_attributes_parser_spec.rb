require 'spec_helper'

RSpec.describe Relevator::RelevantAttributesParser do

  def attributes(expected_data)
    described_class.parse(expected_data)
  end

  describe '#parse' do

    context 'it receives an Array' do

      let(:array_of_strings) do
        [
          'thing_one',
          'thing_two',
          'thing_three'
        ]
      end

      it 'should return a Hash' do
        expect(attributes(array_of_strings)).to be_a Hash
      end

      context 'of strings' do

        it 'should return an empty Hash' do
          expect(attributes(array_of_strings).empty?).to be true
        end

      end

      context 'of Hashes' do

        let(:array_of_similar_objects) do
          [
            { :id       => 1, :name     => 'Travis' },
            { :id       => 2, :name     => 'Tom'    },
            { :id       => 3, :name     => 'Mark'   }
          ]
        end
        let(:array_of_different_objects) do
          [
            { :id         => 1          },
            { :name       => 'Travis'   },
            { :type       => 'Drummer'  }
          ]
        end
        let(:array_of_complex_objects) do
          [
            { :id       => 1, :person   =>
              {
                :name       => 'Travis',
                :type       => 'Drummer'
              }
            },
            { :id       => 2, :person   =>
              {
                :name       => 'Tom',
                :type       => 'Guitar'
              }
            },
            { :id       => 3, :person   =>
              {
                :name       => 'Mark',
                :type       => 'Bass'
              }
            },
          ]
        end

        it 'should return a Hash of the shared properties' do
          expect(attributes(array_of_similar_objects)).to eq(
            {:id => {}, :name => {}}
          )
        end

        it 'should return a Hash of the all properties' do
          expect(attributes(array_of_different_objects)).to eq(
            {:id => {}, :name => {}, :type => {}}
          )
        end

        it 'should return a Hash of all nested properties' do
          expect(attributes(array_of_complex_objects)).to eq(
            {:id => {}, :person => {
              :name => {}, :type => {}
            }}
          )
        end

      end

      context 'of Arrays' do

        let(:array_of_arrays) do
          [
            [1, 2, 3],
            [:one, :two, :three]
          ]
        end

        it 'should return an empty Hash' do
          expect(attributes(array_of_arrays)).to eq({})
        end

      end

    end

    context 'it receives a Hash' do

      let(:complex_object) do
        { :id       => 1, :person   =>
          {
            :name       => 'Travis',
            :type       => 'Drummer'
          }
        }
      end

      it 'should return a Hash of all nested properties' do
        expect(attributes(complex_object)).to eq(
          {:id => {}, :person => {
            :name => {}, :type => {}
          }}
        )
      end

    end

    context 'it receives a non-Hash non-Array value' do

      context 'when receiving a string' do
        it 'should return an empty hash' do
          expect(attributes('arbitrary')).to eq({})
        end
      end

      context 'when receiving an Object' do
        it 'should return an empty hash' do
          expect(attributes(Object.new)).to eq({})
        end
      end

    end

  end

end
