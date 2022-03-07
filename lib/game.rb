class Game
  attr_accessor :attempts, :clue, :game_won, :word, :char_bank

  def initialize
    @word = random_word
    @attempts = 6
    @char_bank = []
    @clue = @word.gsub(/\w/, '_')
    @game_won = false
  end

  def to_yaml
    YAML.dump({
                word: @word,
                attempts: @attempts,
                char_bank: @char_bank,
                clue: @clue,
                game_won: @game_won
              })
  end

  def self.load_game(data)
    game = new
    game.word = data[:word]
    game.attempts = data[:attempts]
    game.char_bank = data[:char_bank]
    game.clue = data[:clue]
    game.game_won = data[:game_won]
    game
  end

  def add_to_bank(value)
    @char_bank.push(value)
  end

  def random_word
    dictionary = File.readlines('google-10000-english-no-swears.txt')
    word = dictionary[rand(0..9893)].chomp
    if word.length >= 5 && word.length <= 12
      word
    else
      random_word
    end
  end

  def user_guess
    puts 'Solve or enter a single character'
    puts "Type 'save' to save game."
    guess = gets.chomp.downcase
    if guess == 'save'
      guess
    elsif guess.length == 1 && guess.match?(/[a-z]/)
      char_bank.include?(guess) ? user_guess : compare_guess(guess)
    elsif guess.length >= 5 && guess.match?(/[a-z]/)
      if guess == word
        puts "solved!"
        self.game_won = true
        self.attempts = 0
      else
        @attempts -= 1
        puts "\e[33mwrong!\e[0m"
      end
    else
      puts guess.length == 1 ? 'Only letters! try again.' : 'too short! try at least 5 letters.'
      user_guess
    end
  end

  def compare_guess(guess)
    if word.include?(guess)
      word.each_char.with_index do |c, i|
        clue[i] = guess if c == guess
      end
      add_to_bank(guess)
      puts "\e[34mMatch!\e[0m"
      if clue == word
        self.attempts = 0
        self.game_won = true
      end
    else
      puts "\e[33mNo match\e[0m"
      add_to_bank(guess)
      @attempts -= 1
    end
  end

  def play_game
    puts "#{clue} \t attempts left:#{attempts}"
    puts "Your letter bank: #{char_bank}"
    user_guess
  end
end
