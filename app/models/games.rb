class Games < ApplicationRecord
  before_create :generate_id

  private

  def generate_id
    logger.info self.id
    loop do
      self.id = SecureRandom.alphanumeric(6).downcase
      break if not Games.where(id: self.id).exists?
    end
  end
end