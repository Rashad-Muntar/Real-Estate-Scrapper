require 'nokogiri'
require 'httparty'
require 'byebug'
require 'colorize'

class Scrapper
  def initialize
    doc = HTTParty.get('https://tonaton.com/en/ads/ghana/property?sort=date&buy_now=0&urgent=0&page=1')
    @parsed_data ||= Nokogiri::HTML(doc.body)
  end

  def data_list
    property.zip(price).to_h
  end

  private

  def property
    @parsed_data.css('ul.list--3NxGO > li > a > div > div > h2').map { |property| property.text.upcase }
  end

  def price
    @parsed_data.css('div.content--3JNQz > div > .price--3SnqI').map do |price|
      price.text.upcase
    end
  end
end
