require 'pry'

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

deck = new_shuffled_deck
card = grab_card!(deck)

p card