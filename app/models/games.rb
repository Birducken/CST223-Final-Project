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

  private 

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

  def generate_id
    logger.info self.id
    loop do
      self.id = SecureRandom.alphanumeric(6).downcase
      break if not Games.where(id: self.id).exists?
    end
  end
end