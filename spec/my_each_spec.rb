require './lib/enumerables'

RSpec.describe 'Enumerable' do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }
  let(:my_results) { [] }

  describe '#my_each' do
    context 'when a block is passed' do
      it 'returns the calling array' do
        expect(array_of_numbers.my_each{ |num| puts num }).to eql(array_of_numbers)
      end
    end

    context 'when a block is passed' do
      it 'does not return an empty array' do
        expect(array_of_numbers.my_each{ |num| puts num }).to_not eql(my_results)
      end
    end

    context 'when a block is not passed' do
      it 'returns an enumerator' do
        expect(array_of_numbers.my_each).to be_an(Enumerator)
      end
    end
  end
end