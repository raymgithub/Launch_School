def show_table(scoreboard, dealer, player)
  system "clear"
  puts "Dealer score is #{scoreboard[:Dealer]} | Player score is #{scoreboard[:Player]}"
  puts "The first player to #{NUMBER_TO_WIN} wins."
  puts "-----------------------------------"
  puts ""
  dealer.size == 2 ? puts "Dealer first card is #{dealer[0].join(' ')}." | puts "Dealer hand is #{card_is(dealer)}."
  puts "The total sum of dealer's hand is #{total_hand_sum(dealer)}"
  puts ""
  puts ""
  puts "Your hand is #{card_is(player)}."
  puts "The total sum of your hand is #{total_hand_sum(player)}"
  puts ""
  puts ""
  puts "-----------------------------------"
end

  puts "Dealer first card is #{dealer[0].join(' ')}."


  dealer.size == 2 ? puts "Dealer first card is #{dealer[0].join(' ')}." | puts "Dealer hand is #{card_is(dealer)}."