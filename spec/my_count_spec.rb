require './lib/enumerables'

RSpec.describe Enumerable do
  let(:array_of_numbers) { [1, 2, 4, 2] }
  let(:my_results) { [] }

  describe '#my_count' do
    context 'when a block is passed without an argument' do
      it 'returns a count of items in the calling array that meet the block condition' do
        expect(array_of_numbers.my_count(&:even?)).to eql(3)
      end
    end

    context 'when an argument(positive integer) is passed without a block' do
      it 'returns the argument(number type)' do
        expect(array_of_numbers.my_count(2)).to eql(2)
      end
    end

    context 'when an argument(negative integer) is passed without a block' do
      it 'returns zero' do
        expect(array_of_numbers.my_count(-2)).to eql(0)
      end
    end

    context 'when a block is passed without an argument' do
      it 'returns zero if the calling array is empty' do
        expect(my_results.my_count).to eql(0)
      end
    end

    context 'when a block is passed without an argument' do
      it 'does not return the calling array' do
        expect(array_of_numbers.my_count(&:even?)).to_not eql(array_of_numbers)
      end
    end

    context 'when a block and an argument are passed' do
      it 'returns an enumerator' do
        expect(array_of_numbers.my_count(2, &:even?)).to be_an(Enumerator)
      end
    end
  end
end
