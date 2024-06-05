TOTAL_SUM_TO_WIN = 21
SCORE_COUNT_TO_WIN = 5

def prompt(msg)
  puts msg
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
             sum + 11 <= TOTAL_SUM_TO_WIN ? 11 : 1
           else
             number
           end
  end
  sum
end

def format_to_phrase(card)
  card.map do |suit, number|
    "#{number} of #{suit}"
  end.join(', ')
end

def deal_to_dealer(deck, hand)
  to = TOTAL_SUM_TO_WIN - 5

  if (4..to).include?(total_hand_sum(hand))
    hand << grab_card!(deck)
  end
end

def dealer_stand?(hand)
  to = TOTAL_SUM_TO_WIN - 1
  from = to - 3
  (from..to).include?(total_hand_sum(hand))
end

def total_to_win?(hand)
  total_hand_sum(hand) == TOTAL_SUM_TO_WIN
end

def bust?(hand)
  total_hand_sum(hand) > TOTAL_SUM_TO_WIN
end

def grab_first_hand(deck, dealer, player)
  num = TOTAL_SUM_TO_WIN.divmod(10)[0]

  num.times do
    dealer << grab_card!(deck)
    player << grab_card!(deck)
  end
end

def hidden_or_not(dealer, player)
    hidden_hand = "Dealer first card is #{dealer[0].join(' of ')}.
  "

  whole_hand = <<HEREDOC
  Dealer hand is #{format_to_phrase(dealer)}.
  The total sum of dealer's hand is #{total_hand_sum(dealer)}
HEREDOC

  if player.size == 2
    hidden_hand
  else
    whole_hand
  end
end

def show_table(scoreboard, dealer, player)
  phrase = hidden_or_not(dealer, player)

  system "clear"
  puts <<HEREDOC
  Dealer score is #{scoreboard[:Dealer]} | Player score is #{scoreboard[:Player]}
  The first hand to reach the total sum of #{TOTAL_SUM_TO_WIN} wins
  ----------------------------------------------------------------------
  
  #{phrase}

  
  
  Your hand is #{format_to_phrase(player)}.
  The total sum of your hand is #{total_hand_sum(player)}
  
  
  ----------------------------------------------------------------------
HEREDOC
end

def add_to_score(scoreboard, who)
  who = case who
        when "Player"
          :Player
        when "Dealer"
          :Dealer
        end

  scoreboard[who] += 1
end

def player_bj_phr
  "You have Black Jack! You won!"
end

def dealer_bj_phr
  "Dealer has Black Jack. You lost."
end

def win?(scoreboard, dealer, player)
  phrase_to_output = total_to_win?(player) ? player_bj_phr : dealer_bj_phr

  if total_to_win?(player) || total_to_win?(dealer)
    system "clear"
    total_to_win?(player) ? add_to_score(scoreboard, "Player") : add_to_score(scoreboard, "Dealer")
    show_table(scoreboard, dealer, player)
    puts phrase_to_output
    true
  end
end

def player_bust_phr
  "You busted. Dealer wins"
end

def dealer_bust_phr
  "Dealer has busted. You won!"
end

def any_bust?(scoreboard, dealer, player)
  phrase_to_output = bust?(player) ? player_bust_phr : dealer_bust_phr

  if bust?(player) || bust?(dealer)
    system "clear"
    bust?(player) ? add_to_score(scoreboard, "Dealer") : add_to_score(scoreboard, "Player")
    show_table(scoreboard, dealer, player)
    puts phrase_to_output
    true
  end
end

def hit_or_stand(scoreboard, dealer, player)
  loop do
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
    hand << grab_card!(deck)
    show_table(scoreboard, dealer, hand)
    break if total_to_win?(hand)
    break if bust?(hand)

    choice = hit_or_stand(scoreboard, dealer, hand)
    break unless choice == "h" || choice == "hit"
  end
end

def dealer_turn!(scoreboard, deck, hand, player)
  loop do
    system "clear"
    if deal_to_dealer(deck, hand)
      show_table(scoreboard, hand, player)
    elsif dealer_stand?(hand) || bust?(hand) || total_to_win?(hand)
      break
    end
  end
end

def draw_game(scoreboard, dealer, player)
  show_table(scoreboard, dealer, player)
  puts "It is a draw"
end

def dealer_hand_greater(scoreboard, dealer, player)
  show_table(scoreboard, dealer, player)
  add_to_score(scoreboard, "Dealer")
  puts "Dealer Won."
end

def player_hand_greater(scoreboard, dealer, player)
  show_table(scoreboard, dealer, player)
  add_to_score(scoreboard, "Player")
  puts "You won!"
end

def who_won?(scoreboard, dealer, player)
  dealer_sum = total_hand_sum(dealer)
  player_sum = total_hand_sum(player)

  if dealer_sum == player_sum
    draw_game
  elsif dealer_sum > player_sum
    dealer_hand_greater
  elsif dealer_sum < player_sum
    player_hand_greater
  end
end

def player_win_sb_phr
  "You reached #{SCORE_COUNT_TO_WIN} first! Making you a winner!"
end

def dealer_win_sb_phr
  "Dealer reached #{SCORE_COUNT_TO_WIN} first. You lost."
end

def scoreboard_win?(scoreboard)
  player_win? = scoreboard[:Player] == SCORE_COUNT_TO_WIN ? true : false

  phrase_to_output = player_win? ? player_win_sb_phr : dealer_win_sb_phr
  
  if scoreboard[:Player] == SCORE_COUNT_TO_WIN || scoreboard[:Dealer] == SCORE_COUNT_TO_WIN
    system "clear"
    puts phrase_to_output
    true
  end
end
