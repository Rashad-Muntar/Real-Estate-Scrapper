require_relative '../lib/scrapper'

describe Scrapper do
  # describe '#price' do
  #   it 'Returns a array containing contents of elements from the NodeSets given' do
  #     scrapper = Scrapper.new
  #     expect(scrapper.price).to be_a Array
  #   end
  # end

  describe '#property' do
    it 'return an array of strings' do
      scrapper = Scrapper.new
      expect(scrapper.property).to be_a Array
    end
    it 'do not return a hash object data type' do
      scrapper = Scrapper.new
      expect(scrapper.property).to_not be_an Hash
    end
  end

  describe '#data_list' do
    it 'returns a hash of all available property listing' do
      scrapper = Scrapper.new
      expect(scrapper.data_list).to be_a Hash
    end

    it 'do not return an array object type' do
      scrapper = Scrapper.new
      expect(scrapper.data_list).to_not be_an Array
    end
  end
end
