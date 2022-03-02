class Game
  attr_accessor :attempts, :clue
  attr_reader :word, :char_bank
  def initialize
    @word = random_word
    @attempts = 6
    @char_bank = []
    @clue = @word.gsub(/\w/, "_")
    play_game
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
    puts "Enter a single character"
    guess = gets.chomp.downcase
    if guess.length == 1 && guess.match?(/[a-z]/)
      puts "valid: #{guess}"
      char_bank.include?(guess) ? user_guess : compare_guess(guess)
    else
      puts "#{guess}: not valid!"
      user_guess
    end
  end

  def compare_guess(guess)
    if word.include?(guess)
      puts "word does cointain #{guess}!"
      word.each_char.with_index do |c, i|
        if c == guess
          clue[i] = guess
        end
      end
      add_to_bank(guess)
      puts "new clue: #{clue}"
    else
      puts "no match adding to bank"
      add_to_bank(guess)
      @attempts -= 1
      puts "attempts:#{attempts}"
    end
  end

  def play_game
    puts "secret word is #{word} with a lenght of #{word.length}"
    puts "#{clue}\tattempts left:#{attempts}"
    while attempts > 0
      user_guess
      puts "Your letter bank: #{char_bank}"
    end
    puts "end of game"
  end
end

Game.new

#word.each_char { |c| compare each char with word }