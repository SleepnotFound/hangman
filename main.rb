require_relative 'game.rb'
require 'yaml'

#instantate a new game 
#game = Game.new
#puts game.class

def load_game
  puts "loading game..."
  data = File.open('saves/save_data_test_1.yaml', 'r').read
  saved_data = YAML.load data
  puts saved_data
  #saved_data
  Game.load_game(saved_data)
end

puts "Press 1 to load a saved game\nPress 2 to start a new game"
mode = gets.chomp
until mode == '1' || mode == '2'
  puts "Press 1 to load a saved game\nPress 2 to start a new game"
  mode = gets.chomp
end
game = mode == '1' ? load_game : Game.new

puts game.class
game.play_game