require 'pry'
def prompt(msg)
  puts "#{msg}"
end

def new_shuffled_deck
  deck_of_cards = []
  card_suits = ["Heart", "Diamond", "Spade", "Club"]
  card_num = ["Ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King"]

  card_suits.each do |suit|
    card_num.each do |num|
      deck_of_cards << [suit, num]
    end
  end

deck_of_cards.shuffle
end


def grab_card!(deck)
deck.pop
end

def total_hand_sum(hand)
  sum = 0
  hand.each do |_, number|
    sum += case number
           when 'Jack', 'Queen', 'King'
             10
           when "Ace"
             sum + 11 <= NUMBER_TO_WIN ? 11 : 1
           else
             number
           end
  end
  sum
end

def card_is(card)
  card.map do |suit, number|
    "#{number} of #{suit}"
  end.join(', ')
end

def deal_to_dealer?(deck, hand)
  to = NUMBER_TO_WIN - 5

  card = grab_card!(deck)
  if (2..to).include?(total_hand_sum(hand))
    hand << card
  end
end

def dealer_stand?(hand)
  to = NUMBER_TO_WIN - 1
  from = to - 3
  (from..to).include?(total_hand_sum(hand))
end

def num_to_win(hand)
  total_hand_sum(hand) == NUMBER_TO_WIN
end

def bust?(hand)
  total_hand_sum(hand) > NUMBER_TO_WIN
end

def grab_first_hand(deck, dealer, player)
  num, remainder = NUMBER_TO_WIN.divmod(10)

  num.times do
    card = grab_card!(deck)
    dealer << card
    card = grab_card!(deck)
    player << card
  end
end

def show_table(scoreboard, dealer, player)
  which_string = player.size == 2 ? "Dealer first card is #{dealer[0].join(' ')}." : "Dealer hand is #{card_is(dealer)}."

  system "clear"
  puts "Dealer score is #{scoreboard[:Dealer]} | Player score is #{scoreboard[:Player]}"
  puts "The first hand total sum to #{NUMBER_TO_WIN} wins."
  puts "-----------------------------------"
  puts ""
  puts which_string
  puts "The total sum of dealer's hand is #{total_hand_sum(dealer)}"
  puts ""
  puts ""
  puts "Your hand is #{card_is(player)}."
  puts "The total sum of your hand is #{total_hand_sum(player)}"
  puts ""
  puts ""
  puts "-----------------------------------"
end

def win?(scoreboard, dealer, player)
  if num_to_win(player)
    system "clear"
    scoreboard[:Player] += 1
    show_table(scoreboard, dealer, player)
    puts "You have Black Jack! You won!"
    true
  elsif num_to_win(dealer)
    system "clear"
    scoreboard[:Dealer] += 1
    show_table(scoreboard, dealer, player)
    puts "Dealer has Black Jack. You lost."
    true
  end
end

def any_bust?(scoreboard, dealer, player)
  if bust?(player)
    system "clear"
    scoreboard[:Dealer] += 1
    show_table(scoreboard, dealer, player)
    puts "You busted. Dealer wins"
    true
  elsif bust?(dealer)
    system "clear"
    scoreboard[:Player] += 1
    show_table(scoreboard, dealer, player)
    puts "Dealer has busted. You won!"
    true
  end
end

def hit_or_stand(scoreboard, dealer, player)
  loop do # show_table method
    prompt "Do you want to (H)it or (S)tand?"
    choice = gets.chomp.downcase
    if ["hit", "h", "stand", "s"].include?(choice)
      return choice
    else
      system "clear"
      show_table(scoreboard, dealer, player)
      prompt "Please choose (H)it or (S)tand."
    end
  end
end

def play_again?
  loop do
    prompt "Do you want to play again? (Y)es or (N)o"
    choice = gets.chomp.downcase
    if ["yes", "y", "no", "n"].include?(choice)
      return choice
    else
      system "clear"
      prompt "Please choose (Y)es or (N)o."
    end
  end
end

def player_turn!(scoreboard, deck, dealer, hand)
  loop do
    system "clear"
    card = grab_card!(deck)
    hand << card
    show_table(scoreboard, dealer, hand)
    break if num_to_win(hand)
    break if bust?(hand)

    choice = hit_or_stand(scoreboard, dealer, hand)
    break unless choice == "h" || choice == "hit"
  end
end

def dealer_turn!(scoreboard, deck, hand, player)
  loop do
    system "clear"
    if deal_to_dealer?(deck, hand)
      show_table(scoreboard, hand, player)
    elsif dealer_stand?(hand) || bust?(hand) || num_to_win(hand)
      break
    end
  end
end

def who_won?(scoreboard, dealer, player)
  dealer_sum = total_hand_sum(dealer)
  player_sum = total_hand_sum(player)

  if dealer_sum == player_sum
    show_table(scoreboard, dealer, player)
    puts "It is a draw."
  elsif dealer_sum > player_sum
    scoreboard[:Dealer] += 1
    show_table(scoreboard, dealer, player)
    puts "Dealer won."
  elsif dealer_sum < player_sum
    scoreboard[:Player] += 1
    show_table(scoreboard, dealer, player)
    puts "You won!"
  end
end

def scoreboard_win?(scoreboard)
  if scoreboard[:Player] == SCORE_TO_WIN
    system "clear"
    puts "You reached #{SCORE_TO_WIN} first! Making you a winner!"
    return true
  elsif scoreboard[:Dealer] == SCORE_TO_WIN
    system "clear"
    puts "Dealer reached #{SCORE_TO_WIN} first. You lost."
    return true
  end
end

NUMBER_TO_WIN = 21
SCORE_TO_WIN = 5

loop do # New Scoreboard
  scoreboard = { Dealer: 0, Player: 0 }
  
  loop do # New Deck, New Dealer hand, New Player Hand
    deck = new_shuffled_deck
    dealer = []
    player = []

    loop do # Game Start
      grab_first_hand(deck, dealer, player)
      show_table(scoreboard, dealer, player)
      break if win?(scoreboard, dealer, player)

      choice = hit_or_stand(scoreboard, dealer, player)
      player_turn!(scoreboard, deck, dealer, player) if choice == "h" || choice == "hit"
      break if win?(scoreboard, dealer, player)
      break if any_bust?(scoreboard, dealer, player)

      dealer_turn!(scoreboard, deck, dealer, player)
      break if win?(scoreboard, dealer, player)
      break if any_bust?(scoreboard, dealer, player)

      who_won?(scoreboard, dealer, player)
      break
    end # Game End
    puts "Press any key to continue"
    key = gets
    break if scoreboard_win?(scoreboard)
  end # End New Deck..

  choice = play_again?
  break unless choice == "yes" || choice == "y"
end # End New Scoreboard