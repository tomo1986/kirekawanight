class Menu < ApplicationRecord
  belongs_to :shop, polymorphic: true

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.type self.type
      json.shop_id self.shop_id
      json.title self.title
      json.sub_title self.sub_title
      json.price self.price
      json.sort_no self.sort_no
    end
  end

  def self.to_jbuilders(menus)
    Jbuilder.new do |json|
      json.array! menus do |menu|
        json.id menu.id
        json.type menu.type
        json.shop_id menu.shop_id
        json.title menu.title
        json.sub_title menu.sub_title
        json.price menu.price
        json.sort_no menu.sort_no
      end
    end
  end


end
