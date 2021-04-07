require './lib/enumerables'

RSpec.describe Enumerable do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }
  # let(:my_hash) { { obj: 'Object', obj1: 'Object1' } }
  let(:my_results) { [] }
  let(:str_array) { %w[cat sheep bear] }
  let(:my_range) { (5..10) }
  let(:any_array) { [nil, false, true] }
  # let(:my_proc) { proc { |item| item * 2 } }

  describe '#my_inject' do
    context 'when a block is passed without an argument' do
      it 'returns a reduced single value as a result of the block execution' do
        expect(array_of_numbers.my_inject { |sum, n| sum + n }).to eql(15)
      end
    end

    context 'when a block is passed without an argument' do
      it 'returns a reduced single value as a result of the block execution' do
        expect(my_range.my_inject { |sum, n| sum + n }).to eql(45)
      end
    end

    context 'when a block is passed with an argument' do
      it 'returns a reduced single value as a result of the block execution' do
        expect(my_range.my_inject(2) { |sum, n| sum * n }).to eql(302_400)
      end
    end

    context 'when a block is passed without an argument' do
      it 'returns a reduced single value as a result of the block execution' do
        expect(str_array.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eql('sheep')
      end
    end

    context 'when a block is passed without an argument' do
      it 'does not return the calling array' do
        expect(array_of_numbers.my_inject { |sum, n| sum + n }).to_not eql(array_of_numbers)
      end
    end
  end
end
