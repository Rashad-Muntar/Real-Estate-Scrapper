require './lib/scrapper'

describe Scrapper do
  describe '#price' do
    it 'Returns a array containing contents of elements from the NodeSets given' do
      scrapper = Scrapper.new
      expect(scrapper.price).to be_a Array
    end
  end

  describe '#property' do
    it 'return a hash of key value pairs from two arrays' do
      scrapper = Scrapper.new
      expect(scrapper.property).to be_a Hash
    end
  end

  describe '#search' do
    it 'return a hash of key value pairs from two arrays' do
      scrapper = Scrapper.new
      expect(scrapper.search).to be_a Array
    end
  end
end
