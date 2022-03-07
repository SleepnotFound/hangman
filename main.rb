require_relative 'game.rb'
require 'yaml'

def pick_save_data
  list = Dir.glob('saves/*').each do |save|
    save.gsub!(/(saves\/)(save\d{2})(.yaml)/, '\2')
  end
  list.each { |l| puts "\e[32m#{l}\e[0m"}
  choice = gets.chomp
  until list.include?(choice)
    puts "Not an available save. Try again."
    choice = gets.chomp
  end
  choice
end

def load_game
  puts "Type in a save file. Available save files:"
  choice = pick_save_data
  puts "save available!"
  puts choice
  data = File.open("saves/#{choice}.yaml", 'r').read
  saved_data = YAML.load data
  Game.load_game(saved_data)
end

def save_data(data)
  Dir.mkdir('saves') unless Dir.exist?('saves')
  puts "Type an available save slot:"
  choice = pick_save_data
  filename = "saves/#{choice}.yaml"
  File.open(filename, 'w') do |file|
    file.puts data
  end
  puts "\e[32myour game has been saved!\e[0m"
end

puts "Press 1 to load a saved game\nPress 2 to start a new game"
mode = gets.chomp
until mode == '1' || mode == '2'
  puts "Incorrect input. 1 to load. 2 for new game"
  mode = gets.chomp
end
game = mode == '1' ? load_game : Game.new

puts "\e[1mStart of Game\n-------------\e[0m"
while game.attempts > 0 
  if game.play_game == 'save'
    puts "save request..."
    save_data(game.to_yaml)
  end
end
puts game.game_won ? "you win!" : "you lose! word was #{game.word}"

