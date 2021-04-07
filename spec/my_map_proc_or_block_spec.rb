require './lib/enumerables'

RSpec.describe Enumerable do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }
  let(:my_results) { [] }
  let(:my_proc) { proc { |item| item * 4 } }
  let(:my_lambda) { ->(item) { item * 7 } }

  describe '#my_map_proc_or_block' do
    context 'when a proc is passed as an argument' do
      it 'returns a converted array of the block execution' do
        expect(array_of_numbers.my_map_proc_or_block(my_proc)).to eql([4, 8, 12, 16, 20])
      end
    end

    context 'when a lambda is passed as an argument' do
      it 'returns a converted array of the block execution' do
        expect(array_of_numbers.my_map_proc_or_block(my_lambda)).to eql([7, 14, 21, 28, 35])
      end
    end

    context 'when a block is passed' do
      it 'returns a converted array of the block execution' do
        expect(array_of_numbers.my_map_proc_or_block { |n| n + 3 }).to eql([4, 5, 6, 7, 8])
      end
    end

    context 'when a proc is passed' do
      it 'does not return the calling array' do
        expect(array_of_numbers.my_map_proc_or_block(my_proc)).to_not eql(array_of_numbers)
      end
    end

    context 'when a proc is passed as an argument' do
      it 'does not return an empty array' do
        expect(array_of_numbers.my_map_proc_or_block(my_proc)).to_not eql(my_results)
      end
    end

    context 'when a block is passed' do
      it 'does not return the calling array' do
        expect(array_of_numbers.my_map_proc_or_block { |n| n + 3 }).to_not eql(array_of_numbers)
      end
    end

    context 'when a block and proc are passed' do
      it 'returns an enumerable' do
        expect(array_of_numbers.my_map_proc_or_block(my_proc) { |n| n + 3 }).to be_an(Enumerable)
      end
    end
  end
end
