class Card < ApplicationRecord
  belongs_to :shop


  def get_card_name
    return 'JCB' if self.type == 'CardType::Jcb'
    return 'Master' if self.type == 'CardType::Master'
    return 'Visa' if self.type == 'CardType::Visa'
    return 'AMEX' if self.type == 'CardType::Amex'
  end
  def self.to_jbuilders(cards)
    Jbuilder.new do |json|
      json.array! cards do |card|
        json.id card.id
        json.name card.get_card_name
        json.shop_id card.shop_id
      end
    end
  end


end