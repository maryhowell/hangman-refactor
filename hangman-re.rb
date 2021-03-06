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

def check_input_for_a_letter input
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
  input
end

def win_or_lose? board, randomword, guesses
  if board == randomword
    puts "YAY you won!!"
    done = true
  elsif guesses == 0
    puts "You lost, Maybe next time"
    puts "The word was #{randomword.join}"
    done = true
  end
  done
end


#Game starts here
loop do
  db = randomword_generator
  puts " Welcome to Hangman"
  randomword = chomp_word(db)
  #puts "your word is #{randomword}" #need to comment out when finished

  board = board_init randomword

  until done || guesses == 0
    puts "Hangman: " + board * " "
    puts "Letters Used: " + prevguess * " "
    puts "You have #{guesses} remaining guesses"
    puts "Choose a letter"
    input = gets.chomp

    check_input_for_a_letter(input)

    some_data = record_compare_guess(randomword, input, board)

    guesses = update_guess_left(board, input, guesses)

    done = win_or_lose?(board, randomword, guesses)
  end
  again = play_again?

  break if again == "n"
  done = false
  guesses = 6
  prevguess = [ ]
end
# binding.pry
