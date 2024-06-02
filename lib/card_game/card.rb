module CardGame
class Card < CardContainer
  attr_accessor :suit, :value

  def initialize(value, suit)
    @suit = suit
    @value = value
  end

  def ==(other)
    if other.nil?
      return false
    end
    
    @value == other.value && @suit == other.suit
  end

  def face?
    @value > 10
  end
end
end