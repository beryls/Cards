class Card
  attr_reader :face, :suit

  def initialize(face, suit)
    @face = face
    @suit = suit
  end

  def to_s
    return @face + @suit
  end
end

class Deck
  def initialize()
    @cards = []
    @used = []
    faces = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suits = %w(C D H S)
    faces.each do |face|
      suits.each do |suit|
        @cards.push(Card.new(face, suit))
      end
    end
    return @cards
  end

  def shuffle
    @used.each do |card|
      @cards.push(card)
    end
    @used = []
    3.times do
      @cards.shuffle!
    end
    @cards.reverse!
    return @cards
  end

  def draw
    if @cards.empty?
      return "No more cards in the deck - time to shuffle!"
    else
      drawn = @cards.pop
      @used.push(drawn)
      return drawn
    end
  end
end
