require './lib/enumerables'

RSpec.describe Enumerable do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }
  let(:str_array) { %w[ant bear cat] }
  # let(:my_hash) { { obj: 'Object', obj1: 'Object1' } }
  let(:my_results) { [] }
  let(:mixed_array) { [1, 3.14, 42] }
  let(:any_array) { [nil, false, true] }
  let(:nil_array) { [nil] }
  # let(:my_proc) { proc { |item| item * 2 } }

  describe '#my_none?' do
    context 'when a block is passed' do
      it 'returns true if none of elements of the array is equal to 10' do
        expect(array_of_numbers.my_none? { |item| item == 10 }).to be(true)
      end
    end

    context 'when a block is passed' do
      it 'returns true if any element of the str_array meets the block condition' do
        expect(str_array.my_none? { |word| word.length == 5 }).to be(true)
      end
    end

    context 'when a block is not passed' do
      it 'returns false if an element in the calling array includes the word Float' do
        expect(mixed_array.my_none?(Float)).to be(false)
      end
    end

    context 'when a block and an argument are not passed' do
      it 'returns true if the calling array is empty' do
        expect(my_results.my_none?).to be(true)
      end
    end

    context 'when an argument is passed alone' do
      it 'returns true if the Regex pattern does not have a match in the calling array' do
        expect(str_array.my_none?(/d/)).to be(true)
      end
    end

    context 'when the calling array has no block or arguments' do
      it 'returns false if none of the elements of the array evaluates to true' do
        expect(any_array.my_none?).to be(false)
      end
    end

    context 'when the calling array has no block or arguments' do
      it 'returns true if none of the elements of the array evaluates to true' do
        expect(nil_array.my_none?).to_not be(false)
      end
    end

    context 'when an argument and a block are passed simultaenously' do
      it 'returns an enumerator' do
        expect(mixed_array.my_none?(3) { |word| word == 3 }).to be_an(Enumerator)
      end
    end
  end
end
