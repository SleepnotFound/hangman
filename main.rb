puts "hangman initialized"

def random_word
  dictionary = File.readlines('google-10000-english-no-swears.txt')
  word = dictionary[rand(0..9893)].chomp
  if word.length >= 5 && word.length <= 12
    word
  else random_word
  end
end

word = random_word
guess = word.gsub(/\w/, "_")
puts "secret word is #{word} with a lenght of #{word.length}"
puts "Enter a single character"
puts guess

#word.each_char { |c| compare each char with word }