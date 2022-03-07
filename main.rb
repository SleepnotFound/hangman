require_relative 'game.rb'
require 'yaml'

def load_game
  puts "Type in a save file. Available save files:"
  list = Dir.glob('saves/*').each do |save|
    save.gsub!(/(saves\/)(save\d{2})(.yaml)/, '\2')
  end
  list.each { |l| puts "\e[32m#{l}\e[0m"}
  choice = gets.chomp
  until list.include?(choice)
    puts "Not an available save. Try again."
    choice = gets.chomp
  end
  puts "save available!"
  data = File.open("saves/#{choice}.yaml", 'r').read
  saved_data = YAML.load data
  Game.load_game(saved_data)
end

puts "Press 1 to load a saved game\nPress 2 to start a new game"
mode = gets.chomp
until mode == '1' || mode == '2'
  puts "Incorrect input. 1 to load. 2 for new game"
  mode = gets.chomp
end
game = mode == '1' ? load_game : Game.new

puts "\e[1mStart of Game\n-------------\e[0m"
game.play_game