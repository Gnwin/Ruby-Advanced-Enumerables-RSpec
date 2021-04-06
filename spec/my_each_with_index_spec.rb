require './lib/enumerables'

RSpec.describe Enumerable do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }
  let(:str_array) { %w[the sumerians ruled] }
  let(:my_hash) { { obj: 'Object', obj1: 'Object1' } }
  let(:my_results) { [] }
  let(:my_proc) { proc { |item| item * 2 } }

  describe '#my_each_with_index' do
    context 'when a block is passed' do
      it 'runs the block and returns the calling array' do
        expect(array_of_numbers.my_each_with_index{ |item, index| puts `I am #{item} and my index is #{index}` }).to eql(array_of_numbers)
      end
    end

    context 'when a block is passed' do
      it 'runs the block passed and does not return an empty array' do
        expect(array_of_numbers.my_each{ |num| puts num }).to_not eql(my_results)
      end
    end

    context 'when a block is not passed' do
      it 'runs the block passed and returns the calling array' do
        expect(array_of_numbers.my_each).to be_an(Enumerator)
      end
    end
  end
end