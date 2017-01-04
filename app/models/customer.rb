class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many  :supports, class_name: 'PostType::Support', as: :sender, dependent: :destroy, :autosave => true
  has_many  :favorites, class_name: 'PostType::Favorite', as: :sender, dependent: :destroy, :autosave => true
  has_many  :review_shops, class_name: 'ReviewType::Shop', as: :sender, dependent: :destroy, :autosave => true
  has_many  :review_users, class_name: 'ReviewType::User', as: :sender, dependent: :destroy, :autosave => true


  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.name self.name
      json.email self.email
      json.tel self.tel
      json.birthday self.birthday
      json.sns_line self.sns_line
      json.sns_zalo self.sns_zalo
      json.sns_wechat self.sns_wechat
      json.favorite_users self.favorites ? User.to_jbuilders(User.where(id: User.where(id: Post.where(receiver_id: self.favorites.pluck(:receiver_id),receiver_type: 'User').pluck(:receiver_id).uniq))) : nil
      json.favorite_shops self.favorites ? Shop.to_jbuilders(Shop.where(id: Shop.where(id: Post.where(receiver_id: self.favorites.pluck(:receiver_id),receiver_type: 'Shop').pluck(:receiver_id).uniq))) : nil
    end
  end

  def self.to_jbuilders(customers)
    Jbuilder.new do |json|
      json.array! customers do |customer|
        json.id customer.id
        json.name customer.name
        json.email customer.email
        json.tel customer.tel
        json.birthday customer.birthday
        json.sns_line customer.sns_line
        json.sns_zalo customer.sns_zalo
        json.sns_wechat customer.sns_wechat
      end
    end
  end

end
