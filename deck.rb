require_relative 'card'

class Deck
  attr_accessor :card

  def initialize
    suit = %w(hearts diamonds clubs spades) #removed commas because they were added to the suit strings for your card objects
    value = (2..10).to_a
    @card = []
    suit.each do |suit|
      value.each do |value|
        @card << Card.new(suit, value, value)
      end
    @card << Card.new(suit, 10, "J")
    @card << Card.new(suit, 10,  "Q")
    @card << Card.new(suit, 10, "K")
    @card << Card.new(suit, 11, "A")
    end
    shuffle!
  end

  def shuffle!
    card.shuffle!
  end

end
