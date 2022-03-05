class Game
  attr_accessor :attempts, :clue, :game_won, :word, :char_bank
  #attr_reader :word, :char_bank
  def initialize
    @word = random_word
    @attempts = 6
    @char_bank = []
    @clue = @word.gsub(/\w/, "_")
    @game_won = false
    #play_game
  end

  def to_yaml
    YAML.dump ({
      :word => @word,
      :attempts => @attempts,
      :char_bank => @char_bank,
      :clue => @clue,
      :game_won => @game_won
    })
  end

  def save_data(data)
    Dir.mkdir('saves') unless Dir.exist?('saves')
    filename = "saves/save_data_test_1.yaml"

    File.open(filename, 'w') do |file|
      file.puts data
    end
  end

  def self.load_game(data)
    puts "calling self load game on class Game"
    game = self.new
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
    else random_word
    end
  end

  def user_guess
    puts "Solve for word or enter a single character"
    puts "Type 'save' to save game."
    guess = gets.chomp.downcase
    if guess == 'save'
      data = self.to_yaml
      save_data(data)
      puts "your game has been saved!"
    elsif guess.length == 1 && guess.match?(/[a-z]/)
      char_bank.include?(guess) ? user_guess : compare_guess(guess)
    elsif guess.length >= 5 && guess.match?(/[a-z]/)
      if guess == word 
        puts "solved! #{guess}"
        self.game_won = true
        self.attempts = 0
      else 
        @attempts -= 1
        puts "wrong! attempts left:#{attempts}"
      end
    else
      puts guess.length == 1 ? "Only letters! try again." : "too short! try at least 5 letters."
      user_guess
    end
  end

  def compare_guess(guess)
    if word.include?(guess)
      word.each_char.with_index do |c, i|
        if c == guess
          clue[i] = guess
        end
      end
      add_to_bank(guess)
      if clue == word
        self.attempts = 0
        self.game_won = true
        puts "Solved! #{clue}"
      end
    else
      puts "no match adding to bank"
      add_to_bank(guess)
      @attempts -= 1
    end
  end

  def play_game
    #puts "secret word is #{word} with a lenght of #{word.length}"
    while attempts > 0
      puts "Your letter bank: #{char_bank}"
      puts "#{clue} \t attempts left:#{attempts}"
      user_guess
    end
    puts game_won ? "you win!" : "you lose! word was #{word}"
  end
end