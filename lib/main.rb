require_relative 'game'
require_relative 'display'
require 'yaml'

def pick_save_data
  list = Dir.glob('saves/*').each do |save|
    save.gsub!(%r{(saves/)(save\d{2})(.yaml)}, '\2')
  end
  list.each { |l| puts "\e[32m#{l}\e[0m" }
  choice = gets.chomp
  until list.include?(choice)
    puts 'Not an available save. Try again.'
    choice = gets.chomp
  end
  choice
end

def load_game
  puts 'Type in a save file. Available save files:'
  choice = pick_save_data
  data = File.open("saves/#{choice}.yaml", 'r').read
  saved_data = YAML.load data
  Game.load_game(saved_data)
end

def save_game(data)
  Dir.mkdir('saves') unless Dir.exist?('saves')
  puts 'Type an available save slot:'
  choice = pick_save_data
  filename = "saves/#{choice}.yaml"
  File.open(filename, 'w') do |file|
    file.puts data
  end
  puts "\e[32myour game has been saved!\e[0m"
end

puts "Press 0 for instructions\nOr 1 to load game.2 to start new game"
mode = gets.chomp
until %w[0 1 2].include?(mode)
  puts 'Incorrect input. 1 to load. 2 for new game. 0 for instructions'
  mode = gets.chomp
end
puts Display::INSTRUCTIONS if mode == '0'

game = mode == '1' ? load_game : Game.new

puts Display::TOP_GAME

while game.attempts > 0
  save_game(game.to_yaml) if game.play_game == 'save'
  break if game.game_won

  case game.attempts
  when 5
    puts Display::SHOW_HEAD
  when 4
    puts Display::SHOW_BODY
  when 3
    puts Display::SHOW_LARM
  when 2
    puts Display::SHOW_RARM
  when 1
    puts Display::SHOW_LLEG
  when 0
    puts Display::SHOW_RLEG
  end
end
puts game.game_won ? 'you win!' : "you lose! word was #{game.word}"
puts Display::BOTTOM_GAME
