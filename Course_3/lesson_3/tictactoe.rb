require 'pry'
require 'pry-byebug'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] 

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'


def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
  system "clear"
  puts "Your marker is #{PLAYER_MARKER}. The computer's marker is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(array, separator = ", ", last = 'or')
  if array.size == 1
    "#{array[0]}"
  elsif array.size == 2
    "#{array[0]} or #{array[1]}"
  else
    separated_array = array.join(separator)
    separated_array_size = separated_array.size
    separated_array.insert(separated_array_size - 1, ' ')
    separated_array.insert(separated_array_size - 1, last)
  end
end

def player_places_piece!(brd)

  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd), ', ')})"
    square = gets.chomp.to_i
    if empty_squares(brd).include?(square)
      break if empty_squares(brd).include?(square)
    else
      prompt "Sorry, that's not a valid choice."
    end
  end

  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = nil

    brd.each do |k, v|
      if k == 5 && v == INITIAL_MARKER
        square = 5
        break
      end
    end

  if !square
    WINNING_LINES.each do |line| # defense
      square = find_at_risk_square(line, brd, COMPUTER_MARKER)
      break if square
    end
  end

  if !square
    WINNING_LINES.each do |line| # offense
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return "Computer"
    end
  end
  nil
end

def place_piece!(brd, current_player)
  if current_player == "Player"
    player_places_piece!(brd)
  elsif current_player == "Computer"
    computer_places_piece!(brd)
  end
end


def alternate_player(player)
  if player == "Player"
    return "Computer"
  elsif player == "Computer"
    return "Player"
  end
end


current_player = ''
player_win_count = 0
computer_win_count = 0

loop do
  board = initialize_board
  prompt "Who do you want to start first? (Y)ou or the (C)omputer?"
  who_starts = gets.chomp.downcase

  loop do 
    if who_starts == 'y'
      current_player = "Player"
    elsif who_starts == 'c'
      current_player = "Computer"
    else
      puts "Please enter either: (Y)ou or (C)omputer"
    end
    break if current_player
  end

    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

  display_board(board)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won!"
        if detect_winner(board) == "Player"
          player_win_count += 1
        else
          computer_win_count += 1
        end
    else
      prompt "It's a tie!"
    end


  puts "The current score is: You: #{player_win_count}, Computer: #{computer_win_count}."
  
  if player_win_count == 5
    puts "Because Player reached 5 wins first. He wins the game!"
    break
  elsif computer_win_count == 5
    puts "Because Computer reached 5 wins first. He wins the game!"
    break
  end

  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp.downcase
  break unless answer.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe!"

