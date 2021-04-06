require './lib/enumerables'

RSpec.describe Enumerable do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }
  # let(:str_array) { %w[the sumerians ruled] }
  # let(:my_hash) { { obj: 'Object', obj1: 'Object1' } }
  let(:my_results) { [] }
  # let(:my_proc) { proc { |item| item * 2 } }

  describe '#my_each_with_index' do
    context 'when a block is passed' do
      it 'returns the calling array' do
        arr1 = array_of_numbers.my_each_with_index do |item, index|
          puts item
          puts index
        end
        expect(arr1).to eql(array_of_numbers)
      end
    end

    context 'when a block is passed' do
      it 'returns the calling array' do
        arr1 = array_of_numbers.my_each_with_index do |item, index|
          puts item
          puts index
        end
        expect(arr1).to_not eql(my_results)
      end
    end

    context 'when a block is not passed' do
      it 'returns an enumerator' do
        expect(array_of_numbers.my_each_with_index).to be_an(Enumerator)
      end
    end
  end
end
