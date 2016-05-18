require "pry"
word = [ ]
board = [ ]
guesses = 6
prevguess = [ ]
done = false
check = false

def randomword_generator
  db = File.open("/usr/share/dict/words").select { |x| (x.length > 3) && (x.length < 6)}
  return db

end

def chomp_word db
  db.sample.chomp.downcase.split("")
end

def board_init randomword
  board = ["_"] * randomword.length
end

def current_guess_to_guessed guess, guessed
  prevguess.push(input)
end

def record_compare_guess randomword, input, board
  i = 0
  randomword.each do |s|
    if s == input
      board[i] = input
    end
    i += 1
  end
  board
end

def update_guess_left board, input, guesses
  if board.include? input
    guesses
  else
    guesses -= 1
  end
  guesses
end

def play_again?
  puts "Would you like to play again y or n?"
  again = gets.chomp
end





#Game starts here
loop do
  db = randomword_generator
  puts " Welcome to Hangman"
  randomword = chomp_word(db)
  puts "your word is #{randomword}" #need to comment out when finished

  board = board_init randomword

  until done || guesses == 0
    puts "Hangman: " + board * " "
    puts "Letters Used: " + prevguess * " "
    puts "You have #{guesses} remaining guesses"
    #choosing a letter and pushing letter choosen to the prevguess array
    puts "Choose a letter"
    input = gets.chomp
    check = false
    until check
      if ("a" .. "z").include?(input)
        check = true
      elsif input.length > 1
        puts "please try another single letter"
        input = gets.chomp
      else puts "please try another single letter"
        input = gets.chomp
      end
    end

 some_data = record_compare_guess(randomword, input, board)

  guesses = update_guess_left(board, input, guesses)

    if board == word
      puts "YAY you won!!"
    elsif guesses == 0
      puts "You lost, Maybe next time"
      puts "The word was #{randomword.join}"
    end
  end

  again = play_again?
  # if again == "n"
  break if again == "n"
  # end
  done = false
  guesses = 6
  prevguess = [ ]
end
# binding.pry
