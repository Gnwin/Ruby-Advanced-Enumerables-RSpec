require './lib/enumerables'

describe '#multiply_els' do
  let(:array_of_numbers) { [1, 2, 3, 4, 5] }
  let(:str_array) { %w[cat sheep bear] }
  let(:my_range) { (5..10) }

  context 'with an argument and a block' do
    it 'returns a reduced single value as a result of the block execution' do
      expect(multiply_els(array_of_numbers) { |sum, n| sum * n }).to eql(120)
    end
  end

  context 'with an argument and a block' do
    it 'returns a reduced single value as a result of the block execution' do
      expect(multiply_els(my_range) { |sum, n| sum * n }).to eql(151_200)
    end
  end

  context 'with an argument and a block' do
    it 'does not return the calling array' do
      expect(multiply_els(array_of_numbers) { |sum, n| sum * n }).to_not eql(array_of_numbers)
    end
  end

  context 'without a block' do
    it 'returns an enumerator' do
      expect(multiply_els(str_array)).to be_an(Enumerator)
    end
  end
end
