require './lib/enumerables'

RSpec.describe Enumerable do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }

  describe '#my_map' do
    context 'when a block is passed without an argument' do
      it 'returns a converted array of the block execution' do
        expect(array_of_numbers.my_map { |item| item + 2 }).to eql([3, 4, 5, 6, 7])
      end
    end

    context 'when a block is passed without an argument' do
      it 'does not return its calling array' do
        expect(array_of_numbers.my_map { |item| item + 2 }).to_not eql(array_of_numbers)
      end
    end

    context 'when a block is passed without an argument' do
      it 'returns an array of boolean elements if the block is a condition' do
        expect(array_of_numbers.my_map(&:even?)).to eql([false, true, false, true, false])
      end
    end

    context 'when a block and an argument are passed' do
      it 'returns an enumerator' do
        expect(array_of_numbers.my_map).to be_an(Enumerator)
      end
    end
  end
end
