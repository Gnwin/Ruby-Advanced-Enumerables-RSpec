require './lib/enumerables'

RSpec.describe Enumerable do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }
  let(:my_results) { [] }
  let(:result_arr) do
    array_of_numbers.my_each_with_index do |item, index|
      puts item
      puts index
    end
  end

  describe '#my_each_with_index' do
    context 'when a block is passed' do
      it 'returns the calling array' do
        expect(result_arr).to eql(array_of_numbers)
      end
    end

    context 'when a block is passed' do
      it 'returns the calling array' do
        expect(result_arr).to_not eql(my_results)
      end
    end

    context 'when a block is not passed' do
      it 'returns an enumerator' do
        expect(array_of_numbers.my_each_with_index).to be_an(Enumerator)
      end
    end
  end
end
