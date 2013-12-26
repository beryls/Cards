load 'deck_of_cards.rb'
require 'pry'

class Hand
  def initialize(cards)

    @face_ranks = {
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

    @cards = (cards.sort_by { |card| @face_ranks[card.face] }.reverse)
    @hand_size = @cards.length

    puts @cards
  end

  # will check matches for specified number of cards more than a pair
  def check_matches(more_than_pair, cards)
    for i in 0..(cards.length - 2 - more_than_pair)
      if cards[i].face == cards[i + more_than_pair + 1].face
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

  # check for straight
  def check_straight(cards)
    for i in 0..(cards.length - 5)
      consecutive = 0
      straight_cards = [cards[i]]
      current_rank = @face_ranks[cards[i].face]
      # binding.pry
      cards.each do |card|
        if @face_ranks[card.face] == current_rank - 1
          consecutive += 1
          straight_cards << card
          current_rank -= 1
          if consecutive == 5
            return straight_cards
          end
        end
      end
      if consecutive == 4 && current_rank == 2
        if cards[0].face == "A"
          straight_cards << cards[0]
          return straight_cards
        end
      end
    end
    return false
  end

  # check for flush - will also be used to check for straight flush
  def check_flush(straight_flush_possible)
    for i in 0..(@cards.length - 5)
      same_suit = 0
      flush_cards = []
      @cards.each do |card|
        if card.suit == @cards[i].suit
          flush_cards << card
          same_suit += 1
          if same_suit == 5
            unless straight_flush_possible
              # binding.pry
              return flush_cards
            end
          end
        end
      end
      if same_suit >= 5
        # binding.pry
        return flush_cards
      end
    end
    return false
  end

  def check_straight_flush
    flush_cards = check_flush(true)
    if flush_cards
      return check_straight(flush_cards)
    end
  end


  def rank_hand
    if check_straight_flush
      straight_flush_cards = check_straight_flush
      if straight_flush_cards[0].face == "A"
        hand_designation = "royal flush"
      else
        hand_designation = "straight flush"
      end
      return "You have a #{hand_designation}: #{straight_flush_cards[0]} #{straight_flush_cards[1]} #{straight_flush_cards[2]} #{straight_flush_cards[3]} #{straight_flush_cards[4]}."
    elsif check_four_of_a_kind
      return "You have four #{check_four_of_a_kind[0]}'s."
    elsif check_full_house
      return "You have a full house - 3 #{check_full_house[0]}'s and 2 #{check_full_house[1]}'s."
    elsif check_flush(false)
      flush_cards = check_flush(false)
      return "You have a flush: #{flush_cards[0]} #{flush_cards[1]} #{flush_cards[2]} #{flush_cards[3]} #{flush_cards[4]}."
    elsif check_straight(@cards)
      straight_cards = check_straight(@cards)
      return "You have a straight: #{straight_cards[0]} #{straight_cards[1]} #{straight_cards[2]} #{straight_cards[3]} #{straight_cards[4]}."
    elsif check_three_of_a_kind
      return "You have three #{check_three_of_a_kind[0]}'s."
    elsif check_two_pair
      return "You have two pair - #{check_two_pair[0]}'s and #{check_two_pair[1]}'s."
    elsif check_pair
      return "You have a pair of #{check_pair[0]}'s."
    else
      return "You only have #{@cards[0].face}-high."
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

