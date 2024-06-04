module GameHelper
  def card_svg(card)
    if card.nil?
      return "blank.svg"
    end
    
    svg = String.new

    case card.value
    when 2..10
      svg += card.value.to_s
    when 1
      svg += "ace"
    when 11
      svg += "jack"
    when 12
      svg += "queen"
    when 13
      svg += "king"
    end

    svg += "_of_"

    case card.suit
    when :clubs
      svg += "clubs"
    when :diamonds
      svg += "diamonds"
    when :hearts
      svg += "hearts"
    when :spades
      svg += "spades"
    end

    svg += ".svg"
    return svg
  end

  def card_png(card)
    if card.nil?
      return "blank_white.png"
    end
    
    png = String.new
    case card.value
    when 2..10
      png += card.value.to_s
    when 1
      png += "ace"
    when 11
      png += "jack"
    when 12
      png += "queen"
    when 13
      png += "king"
    end
    
    png += "_"

    case card.suit
    when :clubs
      png += "clubs"
    when :diamonds
      png += "diamonds"
    when :hearts
      png += "hearts"
    when :spades
      png += "spades"
    end

    png += "_white.png"
    return png
  end
end
