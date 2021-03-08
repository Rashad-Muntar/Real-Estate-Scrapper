require 'nokogiri'
require 'HTTParty'
require 'byebug'
require 'abbrev'
require 'colorize'

class Scrapper
  attr_accessor :parsed_data, :price_arr, :properties_arr, :array

  def initialize
    doc = HTTParty.get('https://tonaton.com/en/ads/ghana/property?sort=date&buy_now=0&urgent=0&page=1')
    @parsed_data ||= Nokogiri::HTML(doc.body)
    @properties_arr = []
    @price_arr = []
  end

  def price
    parsed_data.css('div.content--3JNQz > div > .price--3SnqI').map do |price|
      price.text.upcase
    end
  end

  def property
    parsed_data.css('ul.list--3NxGO > li > a > div > div > h2').map do |property|
      properties_arr << property.text.upcase
    end
    properties_arr.zip(price).to_h
  end

  def display_property
    property.each do |property, _price|
      puts property
      puts '================================================================='.green
    end
  end
end
