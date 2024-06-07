module CardGame
class CardContainer
  def [](i)
    @cards[i]
  end

  def []=(i, other)
    @cards[i] = other
  end

  def top
    @cards.last
  end

  def bottom
    @cards.first
  end

  def each(&lambda)
    @cards.each(&lambda)
  end
end
end