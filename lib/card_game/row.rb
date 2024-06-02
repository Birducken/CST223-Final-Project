module CardGame
class Row < CardContainer
  attr_reader :limit

  def initialize(limit = 0)
    @limit = limit
    @cards = Array.new(limit)
  end

  def replenish(card)
    @cards[@cards.index(nil)] = card
  end

  def empty_slots?
    @cards.any?(nil)
  end

  def empty?
    @cards.all?(nil)
  end

  def limit?
    @cards.size > limit
  end

  def full?
    @cards.none?(nil)
  end
end
end