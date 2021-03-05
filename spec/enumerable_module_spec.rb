require './enumerable_module'

describe Enumerable do
  let(:array) { [1, 2, 3, 4] }
  let(:string_array) { %w[ab abc abcdta] }
  let(:num_str_array) { ['a', 2, 'abc', 5, 'xyzab', 3] }
  let(:hash) { { a: 5, b: 8, c: 3, d: 4, e: 9 } }
  let(:number_array) { [1, 21, 3.5] }
  let(:range) { Range.new(1, 50) }
  let(:number_block) { proc { |num| num * 2 } }
  let(:array_clone) { array.clone }
  let(:block) { proc { |item| item.length >= 3 } }
  let(:true_block) { proc { |str| str.is_a? String } }

  describe '#my_each' do
    it 'Works similar to #each method when a block is given.' do
      expect(array.my_each { |els| (els + 2) }).to eq(array.each { |idx| idx.send('+', 2) })
    end
    it 'returns enumerator if block is not given' do
      expect(array.my_each).to be_an(Enumerator)
    end
    it ' return original array' do
      array.my_each { |el| el * 2 }
      expect(array).to eql(array_clone)
    end
  end

  describe '#my_each_with_index' do
    it 'Works similar to #each method when a block is given.' do
      expect(array.my_each_with_index { |els, index| els + index }).to eql(array.each_with_index do |i, index|
                                                                             i + index
                                                                           end)
    end
    it 'returns enumerator if block is not given' do
      expect(array.my_each_with_index).to be_an(Enumerator)
    end
    it 'return original array' do
      array.my_each_with_index { |el, index| el * index }
      expect(array).to eql(array_clone)
    end
  end

  describe '#my_select' do
    it 'returns array of elements that is true to given block' do
      expect(string_array.my_select(&block)).to eql(string_array.select(&block))
    end

    it 'returns an array of of all element that is true to the given block if self is a range' do
      expect(range.my_select(&number_block)).to eql(range.select(&number_block))
    end

    it 'returns an enumerator if no block is given' do
      expect(array.my_select).to be_an(Enumerator)
    end
    it 'does not alter the original array' do
      array.my_select { |num| num + 5 }
      expect(array).to eq(array_clone)
    end
  end

  describe '#my_all?' do
    it 'return true if block never eveluate to false or nil' do
      expect(string_array.my_all?(&true_block)).to eql(string_array.all?(&true_block))
    end

    it 'return false if block never eveluate to true' do
      expect(num_str_array.my_all?(&true_block)).to eql(num_str_array.all?(&true_block))
    end

    it 'does not change the state of the original array' do
      array.my_all? { |num| num + 1 }
      expect(array).to eq(array_clone)
    end

    context 'when argument is a class' do
      it 'returns true if all elements belongs to the class' do
        expect(string_array.my_all?(String)).to be string_array.all?(String)
      end

      it 'returns false if at least one of the element does not belong to the class' do
        expect(num_str_array.my_all?(String)).to be num_str_array.all?(String)
      end
    end

    context 'when no block or argument is given' do
      it 'returns true if all element of the array evaluate to true' do
        expect(num_str_array.my_all?).to be num_str_array.all?
      end

      it 'returns false if all element of the array does not evaluate to true' do
        num_str_array << nil
        expect(num_str_array.my_all?).to be num_str_array.all?
      end
    end

    context 'when a regex is passed as argument' do
      it 'returns true if all element matches pattern' do
        expect(string_array.my_all?(/a/)).to be string_array.all?(/a/)
      end

      it 'returns false if all element does not matche the pattern' do
        expect(string_array.my_all?(/a/)).to be string_array.all?(/a/)
      end
    end

    context 'when an object is passed as an argument' do
      it 'return true if all elements matches given object' do
        arr = [2, 2, 2, 2]
        expect(arr.my_all?(2)).to be arr.all?(2)
      end

      it 'return false if all elements does not matches given object' do
        arr = [2, 2, 3, 2]
        expect(arr.my_all?(3)).to be arr.all?(3)
      end
    end
  end

  describe '#my_any'
  it 'return true if block eveluate to true at least once' do
    expect(num_str_array.my_any?(&true_block)).to eql(num_str_array.any?(&true_block))
  end

  it 'return false if the block never eveluate to true' do
    expect(array.my_any?(&true_block)).to eql(array.any?(&true_block))
  end

  it 'does not mutate the original array' do
    array.my_any? { |num| num + 1 }
    expect(array).to eq(array_clone)
  end

  context 'when argument is a class' do
    it 'returns true if at least one elements belongs to the class' do
      expect(num_str_array.my_any?(String)).to be num_str_array.any?(String)
    end

    it 'returns false if none of the element does not belong to the class' do
      expect(array.my_any?(String)).to be array.any?(String)
    end
  end

  context 'when no block or argument is given' do
    it 'returns true if at least one element of the array evaluate to true' do
      expect(num_str_array.my_any?).to be num_str_array.any?
    end

    it 'returns false if none of element of the array evaluate to true' do
      false_arr = [nil, false, nil, false]
      expect(false_arr.my_any?).to be false_arr.any?
    end
  end

  context 'when a regex is passed as argument' do
    it 'returns true if at least one element matches pattern' do
      expect(string_array.my_any?(/a/)).to be string_array.any?(/a/)
    end

    it 'returns false if any element does not matche the pattern' do
      expect(string_array.my_any?(/z/)).to be string_array.any?(/z/)
    end
  end

  context 'when an object is passed as an argument' do
    it 'return true if at least one elements matches given object' do
      arr = [2, 1, 4, 3]
      expect(arr.my_any?(2)).to be arr.any?(2)
    end

    it 'return false if none of the elements matches given object' do
      arr = [2, 2, 2, 2]
      expect(arr.my_any?(3)).to be arr.any?(3)
    end
  end

  describe '#my_none?' do
    it 'return true if block does not eveluate to true at least once' do
      expect(array.my_none?(&true_block)).to eql(array.none?(&true_block))
    end

    it 'return false if block eveluate to true at least once' do
      expect(num_str_array.my_none?(&true_block)).to eql(num_str_array.none?(&true_block))
    end

    it 'does not mutate the original array' do
      array.my_none? { |num| num + 1 }
      expect(array).to eq(array_clone)
    end

    context 'when argument is a class' do
      it 'returns true if none of the elements belongs to the class' do
        expect(array.my_none?(String)).to be array.none?(String)
      end

      it 'returns false if at least one of the element belongs to the class' do
        expect(num_str_array.my_none?(String)).to be num_str_array.none?(String)
      end
    end

    context 'when no block or argument is given' do
      it 'returns true if none of the elements of the array evaluate to true' do
        false_arr = [nil, false, nil, false]
        expect(false_arr.my_none?).to be false_arr.none?
      end

      it 'returns false if at leasyt one of the element of the array evaluate to true' do
        expect(num_str_array.my_none?).to be num_str_array.none?
      end
    end

    context 'when a regex is passed as argument' do
      it 'returns true if none of the element matches pattern' do
        expect(string_array.my_none?(/z/)).to be string_array.none?(/z/)
      end

      it 'returns false if at least one of the elements matches the pattern' do
        expect(string_array.my_none?(/a/)).to be string_array.none?(/a/)
      end
    end

    context 'when an object is passed as an argument' do
      it 'return true if none of the elements matches given object' do
        arr = [2, 1, 4, 3]
        expect(arr.my_none?(5)).to be arr.none?(5)
      end

      it 'return false if at least one of the elements matches given object' do
        arr = [2, 3, 2, 2]
        expect(arr.my_none?(3)).to be arr.none?(3)
      end
    end
  end
end
