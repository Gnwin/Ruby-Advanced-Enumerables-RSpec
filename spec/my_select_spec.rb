require './lib/enumerables'

RSpec.describe Enumerable do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }
  let(:my_results) { [] }

  describe '#my_select' do
    context 'when a block is passed' do
      it 'returns a filtered array' do
        expect(array_of_numbers.my_select { |item| item != 2 }).to eql([1, 3, 4, 5])
      end
    end

    context 'when a block is passed' do
      it 'does not return an empty array' do
        expect(array_of_numbers.my_select { |item| item != 2 }).to_not eql(my_results)
      end
    end

    context 'when a block is passed' do
      it 'does not return the calling array' do
        expect(array_of_numbers.my_select { |item| item != 2 }).to_not eql(array_of_numbers)
      end
    end

    context 'when a block is not passed' do
      it 'returns an enumerator' do
        expect(array_of_numbers.my_select).to be_an(Enumerator)
      end
    end
  end
end
