load 'deck_of_cards.rb'
require 'pry'

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

    @cards = (cards.sort_by { |card| face_ranks[card.face] }.reverse)
    @hand_size = @cards.length

    puts @cards
  end

  # will check matches for specified number of cards more than a pair
  def check_matches(above_pair, cards)
    for i in 0..(cards.length - 2 - above_pair)
      if cards[i].face == cards[i + above_pair + 1].face
        other_cards = cards.reject { |card| card.face == cards[i].face }
        return [cards[i].face, other_cards]
      end
    end
    return false
  end

  # check for a pair
  def check_pair
    return check_matches(0, @cards)
  end

  # check for two pair
  def check_two_pair
    if check_pair
      first_pair = check_pair[0]
      other_cards = check_pair[1]
      if check_matches(0, other_cards)
        return [first_pair, check_matches(0, other_cards)].flatten
      else
        return false
      end
    else
      return false
    end
  end

  # check for three of a kind
  def check_three_of_a_kind
    return check_matches(1, @cards)
  end

  # check for a full house
  def check_full_house
    if check_three_of_a_kind
      threes = check_three_of_a_kind[0]
      other_cards = check_three_of_a_kind[1]
      if check_matches(0, other_cards)
        return [threes, check_matches(0, other_cards)].flatten
      else
        return false
      end
    else
      return false
    end
  end

  # check for four of a kind
  def check_four_of_a_kind
    return check_matches(2, @cards)
  end

  def rank_hand
    if check_four_of_a_kind
      return "You have four #{check_four_of_a_kind[0]}'s."
    elsif check_full_house
      return "You have a full house - 3 #{check_full_house[0]}'s and 2 #{check_full_house[1]}'s."
    elsif check_three_of_a_kind
      return "You have three #{check_three_of_a_kind[0]}'s."
    elsif check_two_pair
      return "You have two pair - #{check_two_pair[0]}'s and #{check_two_pair[1]}'s."
    elsif check_pair
      return "You have a pair of #{check_pair[0]}'s."
    else
      return "You only have high card."
    end
    # check for a straight flush
    # for i in 0..(@hand_size - 5)
    #   straight_flush = 0
    #   # if
    #   # end
    # end

  end

end

stacked = Deck.new
stacked.shuffle

dummy_hand = []
7.times do
  dummy_hand.push(stacked.draw)
end

my_hand = Hand.new(dummy_hand)
puts my_hand.rank_hand

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

