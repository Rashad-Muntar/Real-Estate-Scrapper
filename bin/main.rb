require './lib/scrapper'
require 'colorize'

puts '********  YOU WELCOME TO LOGIC PROPERTIES CHOICE ********* '.blue

new_search = Scrapper.new

puts '********* DO YOU HAVE A SPECIFIC PROPERTY YOU ARE LOOKING FOR ENTER NAME BELOW ? ********'.red
search_input = gets.chomp.upcase
selected = new_search.property.select do |key, _val|
  key.include?(search_input[/\w+/])
end
selected.each do |items|
  puts items
  puts '============================================================================='.green
end

puts "YOU CAN VIEW ALL AVAILABLE PROPERTIES ENTER 'YES' or 'NO'".red
input = gets.chomp.upcase
while input != 'YES' || input != 'NO'
  case input
  when 'YES'
    puts 'HMM DIFICULT BUT WAIT A SECOND ALMOST THERE ***** LOADING *******'.red
    new_search.display_property
    break
  when 'NO'
    puts 'OK NO PROBLEM. REMEMBER WE ARE ALWAYS HERE FOR YOU'.red
    break
  end
end
