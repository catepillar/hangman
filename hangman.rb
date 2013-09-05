class HangmanGame

  attr_reader :game_word, :game_letters, :game_over, :guessed_letters, :turns, :letter, :counter

  def initialize
    @game_over = false
    @guessed_letters = []
    @turns = 7
  end

  def play
    @game_word = random_word
    @game_letters = @game_word.chars.to_a

    print_instructions

    while !@game_over
      get_letter
      if have_lives?
        puts "Guess another letter"
        get_response

        @guessed_letters << @letter

        print_word
        check_won
      else
        lost
      end
    end
  end

  def game_end
    @game_over = true
  end

  def lost
    puts "Mwahaha, the superior computer remains superior"
    puts "The word was obviously #{@game_word}"
    game_end
  end

  def check_won
    @counter = @game_word.size
    @game_letters.each do |l|
      if @guessed_letters.include? l
        @counter = @counter - 1
        if @counter == 0
          puts "You are victorious human. For now..."
          puts "The word was in fact #{@game_word}"
          game_end
        end
      end
    end
  end

  def print_word
    @game_letters.each do |l|
      if @guessed_letters.include? l
        print "#{l} "
      else
        print "__ "
      end
    end
    puts ""
  end

  def have_lives?
    @turns > 1
  end

  def get_response
    if @letter.size != 1
      puts "This is not a valid input foolish human"
    elsif @guessed_letters.include? @letter
      puts "You have already guessed the letter #{@letter} silly mortal"
    elsif @game_letters.include? @letter
      puts "Yes, this word does include #{@letter}, but you shall not defeat me"
    else
      @turns -= 1
      puts "Fool, this word does not contain your worthless letter #{@letter}. You have #{@turns} guesses left."
    end
  end

  def get_letter
    @letter = gets.chomp.downcase
  end

  def random_word
    # downside: reads the entire text file into memory each time this method is called
    File.readlines(File.join('dictionaries', 'gsl.txt')).sample.strip
  end

  def print_instructions
    puts "Welcome to Hangman, where I, the computer, am champion of words"
    puts "Guess a letter, if you dare"
    puts "__ " * @game_word.size
  end

end

HangmanGame.new.play
