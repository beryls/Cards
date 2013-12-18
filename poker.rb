load 'deck_of_cards.rb'

class Hand
  def initialize(cards)

    face_ranks = {
      'L' => 1,
      '2' => 2,
      '3' => 3,
      '4' => 4,
      '5' => 5,
      '6' => 6,
      '7' => 7,
      '8' => 8,
      '9' => 9,
      '10' => 10,
      'J' => 11,
      'Q' => 12,
      'K' => 13,
      'A' => 14
    }

    @cards = cards.sort_by { |card| face_ranks[card.face] }

    puts @cards
  end

  def rank
  end
end

stacked = Deck.new
stacked.shuffle

my_hand = []
5.times do
  my_hand.push(stacked.draw)
end

Hand.new(my_hand)

# class Round
# end

# Royal Flush
# Straight Flush
# Four of a Kind
# Full House
# Flush
# Straight
# Three of a Kind
# Two Pair
# Pair
# High Card

