module CardGame
class Row < CardContainer
  attr_reader :limit

  def initialize(limit = 0)
    @limit = limit
    @cards = Array.new(limit)
    @overflow = Array.new;
  end

  def replenish(card)
    if empty_slots?
      @cards[@cards.index(nil)] = card
    else
      @overflow.push(card);
    end
  end

  def overflow?
    !@overflow.empty?
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

  def take_at(i)
    card = @cards[i]
    @cards[i] = nil
    return card
  end

  def compact
    @cards = @cards.compact
    while @cards.size < limit
      @cards.push nil
    end
  end
end
end