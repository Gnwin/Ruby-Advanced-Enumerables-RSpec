require './lib/enumerables'

RSpec.describe Enumerable do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }
  let(:my_proc) { proc { |item| item * 4 } }
  let(:my_lambda) { ->(item) { item * 7 } }

  describe '#my_map_proc' do
    context 'when a proc is passed as an argument' do
      it 'returns a converted array of the block execution' do
        expect(array_of_numbers.my_map_proc(my_proc)).to eql([4, 8, 12, 16, 20])
      end
    end

    context 'when a lambda is passed as an argument' do
      it 'returns a converted array of the block execution' do
        expect(array_of_numbers.my_map_proc(my_lambda)).to eql([7, 14, 21, 28, 35])
      end
    end

    context 'when a block is passed' do
      it 'returns an enumerator' do
        expect(array_of_numbers.my_map_proc { |n| n + 3 }).to be_an(Enumerator)
      end
    end

    context 'when a proc is passed as an argument' do
      it 'does not return the calling array' do
        expect(array_of_numbers.my_map_proc(my_proc)).to_not eql(array_of_numbers)
      end
    end
  end
end
