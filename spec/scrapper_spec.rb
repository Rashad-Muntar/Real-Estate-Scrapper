require_relative '../lib/scrapper'

describe Scrapper do
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
