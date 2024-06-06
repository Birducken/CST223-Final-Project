module CardGame
class Deck < CardContainer
  def initialize(deck_type = :empty)
    populate(deck_type)
  end

  def populate(deck_type)
    case deck_type
    when :standard
      construct_standard
    when :empty
      construct_empty
    end
  end

  def draw
    @cards.pop
  end

  def place(card)
    @cards.push(card)
  end

  def shuffle
    @cards = @cards.shuffle
  end

  def empty?
    @cards.empty?
  end

  def size
    @cards.size
  end

  private

  def construct_empty
    @cards = Array.new
  end

  def construct_standard
    values = *(1..13)
    suits = [:clubs, :diamonds, :hearts, :spades]

    @cards = Array.new

    suits.each do |s|
      values.each do |v|
        @cards.push(Card.new(v, s))
      end
    end
  end
end
end