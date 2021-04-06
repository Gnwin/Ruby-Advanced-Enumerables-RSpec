require './lib/enumerables'

RSpec.describe Enumerable do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }
  let(:str_array) { %w[ant bear cat] }
  # let(:my_hash) { { obj: 'Object', obj1: 'Object1' } }
  let(:my_results) { [] }
  let(:mixed_array) { [1, 2i, 3.14] }
  let(:any_array) { [nil, true, 99] }
  # let(:my_proc) { proc { |item| item * 2 } }

  describe '#my_any?' do
    context 'when a block is passed' do
      it 'returns true if any element of the array is equal to 2' do
        expect(array_of_numbers.my_any? { |item| item == 2 }).to be(true)
      end
    end

    context 'when a block is passed' do
      it 'returns true if any element of the str_array meets the block condition' do
        expect(str_array.my_any? { |word| word.length >= 3 }).to be(true)
      end
    end

    context 'when a block is not passed' do
      it 'returns false if the calling array is empty' do
        expect(my_results.my_any?).to be(false)
      end
    end

    context 'when an argument is passed alone' do
      it 'returns false if the Regex pattern does not have a match in the calling array' do
        expect(str_array.my_any?(/d/)).to be(false)
      end
    end

    context 'when the calling array has no block or arguments' do
      it 'returns true if any the elements of the array evaluates to true' do
        expect(any_array.my_any?).to be(true)
      end
    end

    context 'when an argument and a block are passed simultaenously' do
      it 'returns an enumerator' do
        expect(mixed_array.my_any?(3) { |word| word == 3 }).to be_an(Enumerator)
      end
    end
  end
end