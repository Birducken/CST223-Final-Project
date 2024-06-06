class Games < ApplicationRecord
  before_create :generate_id
  serialize :deck, class: CardGame::Deck, coder: YAML
  serialize :discard, class: CardGame::Deck, coder: YAML
  serialize :vault, class: CardGame::Deck, coder: YAML
  serialize :assets, class: CardGame::Row, coder: YAML
  serialize :public_sales, class: CardGame::Row, coder: YAML
  serialize :private_sales, class: CardGame::Row, coder: YAML
  serialize :game_state, class: Symbol, coder: YAML

  def setup
    self.deck = CardGame::Deck.new(:standard)
    self.deck.shuffle

    self.discard = CardGame::Deck.new(:empty)
    self.vault = CardGame::Deck.new(:empty)

    self.assets = CardGame::Row.new(5)
    self.public_sales = CardGame::Row.new(5)
    self.private_sales = CardGame::Row.new(5)

    self.game_state = :in_progress

    refill_public_sales
    refill_assets
  end

  def valid_transaction?(bought_index, sold_indeces)
    sold = sold_indeces.map { |i| self.assets[i] }
    bought = market_card(bought_index)

    return valid_purchase?(bought, sold) || valid_swap?(bought, sold)
  end

  def perform_transaction(bought_index, sold_indeces)
    sold_indeces.each do |i|
      self.discard.place(self.assets.take_at(i))
    end

    if bought_index <= 4
      card = self.public_sales.take_at(bought_index)
    else
      card = self.private_sales.take_at(bought_index - 5)
    end
    
    if card.face?
      self.vault.place(card)
    else
      self.assets.replenish(card)
    end

    cleanup
  end

  private

  def any_valid_transactions?()
    assets.each do |sold|
      private_sales.each do |bought|
        if valid_swap(bought,sold)
          return true
        end
      end
      public_sales.each do |bought|
        if valid_swap(bought,sold)
          return true
        end
      end
    end
    assets_club = Array.new
    assets_hearts = Array.new
    assets_diamonds = Array.new
    assets_spades = Array.new
    assets.each do |sold|
      c=0
      d=0
      s=0
      h=0
      if card.suit==:clubs
        self.assets_club[c] = self.card
        c++
      end
      if card.suit==:diamonds
        self.assets_diamonds[d] = self.card
        d++
      end
      if card.suit==:spades
        self.assets_spades[s] = self.card
        s++
      end
      if card.suit==:hearts
        self.assets_hearts[h] = self.card
        h++
      end
    end
    return valid_purchase(private_sales,assets_club)||valid_purchase(private_sales,assets_diamonds)||valid_purchase(private_sales,assets_hearts)||valid_purchase(private_sales,assets_spades)||valid_purchase(public_sales,assets_club)||valid_purchase(public_sales,assets_diamonds)||valid_purchase(public_sales,assets_hearts)||valid_purchase(public_sales,assets_spades)
    
  end

  def valid_purchase?(bought, sold)
    if bought == nil
      return false
    end
    
    suit = sold.first.suit
    if !sold.all? { |card| card.suit == suit } || bought.suit != suit
      return false
    end

    sum = sold.sum { |card| sold_value(card) }
    if sum < bought.value
      return false
    end
    
    return true
  end

  def valid_swap?(bought, sold)
    if sold.size != 1 || bought == nil
      return false
    end

    return bought.value == sold[0].value
  end

  def refill_assets
    while self.assets.empty_slots? && !self.deck.empty?
      card = deck.draw
      if !card.face?
        self.assets.replenish(card)
      elsif self.private_sales.full?
        self.game_state = :lost
      else 
        self.private_sales.replenish(card)
      end
    end
  end

  def refill_public_sales
    while self.public_sales.empty_slots? && !self.deck.empty?
      card = deck.draw

      self.public_sales.replenish(card)
    end
  end

  def market_card(i)
    if i <= 4
      card = self.public_sales[i]
    else
      card = self.private_sales[i - 5]
    end
    return card
  end

  def sold_value(card)
    if card.value == 1
      return 11
    end

    return card.value
  end

  def cleanup
    self.private_sales.compact
    refill_public_sales
    refill_assets
  end

  def generate_id
    loop do
      self.id = SecureRandom.alphanumeric(6).downcase
      break if not Games.where(id: self.id).exists?
    end
  end
end