module Display
  INSTRUCTIONS =
    <<~HEREDOC
      Hangman Instructions:

      The computer will choose a random word no less than 5 characters long.
      Your clue will represent the word length in underscores.

      Each turn you have the option to enter a word(solve) or enter 1 letter(guess).
      Entering a letter will update your clue if you guessed a correct letter in the word
      Entering the full word correctly will finish the game.

      Your task is to guess the word within 6 turns.
      Typing in 'save' will allow you to save your progress.

      Best of luck!

      Starting new game...

    HEREDOC
  TOP_GAME = "\e[1mStart of Game\n-------------\e[0m"
  BOTTOM_GAME = "\e[1mGame end\n-------------\e[0m"

  SHOW_HEAD = "\t O"
  SHOW_BODY = "\t O\n\t |"
  SHOW_LARM = "\t O\n\t/|"
  SHOW_RARM = "\t O\n\t/|\\"
  SHOW_LLEG = "\t O\n\t/|\\\n\t/ "
  SHOW_RLEG = "\t O\n\t/|\\\n\t/ \\"
end
