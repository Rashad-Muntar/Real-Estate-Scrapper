require 'nokogiri'
require 'HTTParty'
require 'byebug'
require 'abbrev'
require 'colorize'

class Scrapper
  attr_accessor :parsed_data, :price_arr, :properties_arr, :array

  def initialize
    doc = HTTParty.get('https://tonaton.com/en/ads/ghana/property?sort=date&buy_now=0&urgent=0&page=1')
    @parsed_data ||= Nokogiri::HTML(doc)
    @properties_arr = []
    @price_arr = []
  end

  def price
    parsed_data.css('div.content--3JNQz > div > .price--3SnqI').map { |property| property.text.upcase }
  end

  def property
    parsed_data.css('ul.list--3NxGO > li > a > div > div > h2').map do |property|
      properties_arr << property.text.upcase
    end
    properties_arr.zip(price).to_h
  end

  def display_property
    property.each do |property, price|
      puts "#{property.green}  ==========>  #{price.blue}"
      puts '================================================================='
    end
  end

  def search
    puts '********* DO YOU HAVE A SPECIFIC PROPERTY YOU ARE LOOKING FOR? ********'.red
    search_input = gets.chomp.upcase
    selected = property.select do |key, _val|
      key.include?(search_input[/\w+/])
    end
    selected.each do |items|
      puts items
      puts '============================================================================='.green
    end
  end

  def run
    puts 'DO YOU WANT TO SEE ALL AVAILABLE PROPERTIES TYPE YES or NO'.red
    input = gets.chomp.upcase
    while input != 'YES' || input != 'NO'
      case input
      when 'YES'
        puts 'HMM DIFICULT BUT WAIT A SECOND ALMOST THERE ***** LOADING ******'.red
        display_property
        search
        break
      when 'NO'
        puts 'OK NO PROBLEM. REMEMBER WE ARE ALWAYS HERE FOR YOU'.red
        break
      end
    end
  end
end
