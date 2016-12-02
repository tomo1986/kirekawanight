class Shop < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :group

  has_many  :images, class_name: 'ImageType::Shop', as: :subject, dependent: :destroy, :autosave => true
  has_many :users
  has_many :time_discounts, class_name: 'DiscountType::Time', as: :subject, dependent: :destroy, :autosave => true

  has_many  :contacts, class_name: 'ContactType::ShopDetail', as: :subject, dependent: :destroy, :autosave => true
  has_many  :supports, class_name: 'PostType::Support', as: :receiver, dependent: :destroy, :autosave => true
  has_many  :favorites, class_name: 'PostType::Favorite', as: :receiver, dependent: :destroy, :autosave => true
  has_many  :reviews, class_name: 'ReviewType::Shop', as: :receiver, dependent: :destroy, :autosave => true

  has_many  :top_pickups, class_name: 'PickupType::Top', as: :subject, dependent: :destroy, :autosave => true
  has_many  :puth_pickups, class_name: 'PickupType::Push', as: :subject, dependent: :destroy, :autosave => true

  has_many  :top_banners, class_name: 'BannerType::Top', as: :subject, dependent: :destroy, :autosave => true
  has_many  :top_side_pickups, class_name: 'BannerType::TopSide', as: :subject, dependent: :destroy, :autosave => true

  has_many  :karaoke_banners, class_name: 'BannerType::Top', as: :subject, dependent: :destroy, :autosave => true
  has_many  :massage_pickups, class_name: 'BannerType::TopSide', as: :subject, dependent: :destroy, :autosave => true
  has_many  :bar_pickups, class_name: 'BannerType::TopSide', as: :subject, dependent: :destroy, :autosave => true


  acts_as_taggable_on :labels
  acts_as_taggable

  scope :find_open, -> () {
    return self.where(deleted_at: nil)
  }


  def open_discounts
    now = Time.zone.now
    return self.time_discounts.where('start_at <= ? and end_at > ?',now, now)
  end

  def self.to_jbuilders(shops)
    Jbuilder.new do |json|
      json.array! shops do |shop|
        json.id shop.id
        json.name shop.name
        json.name_kana shop.name_kana
        json.job_type shop.job_type
        json.tel shop.tel
        json.email shop.email
        json.address shop.address
        json.lat shop.lat
        json.lon shop.lon
        json.interview_ja shop.interview_ja
        json.interview_vn shop.interview_vn
        json.interview_en shop.interview_en
        json.sns_line shop.sns_line
        json.sns_zalo shop.sns_zalo
        json.sns_wechat shop.sns_wechat
        json.is_credit shop.is_credit
        json.is_japanese shop.is_japanese
        json.is_english shop.is_english
        json.is_chinese shop.is_chinese
        json.is_korean shop.is_korean
        json.score shop.score
        json.tip shop.tip
        json.girls_count shop.girls_count
        json.is_smoked shop.is_smoked
        json.opened_at shop.opened_at
        json.closed_at shop.closed_at
        json.budget_yen shop.budget_yen
        json.budget_vnd shop.budget_vnd
        json.budget_usd shop.budget_usd
        json.service shop.service
        json.user_count shop.users.count
        # json.note shop.note
        json.images shop.abc
        json.tags shop.tag_list ? shop.tag_list : nil
      end
    end
  end



  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.name self.name
      json.name_kana self.name_kana
      json.job_type self.job_type
      json.tel self.tel
      json.email self.email
      json.address self.address
      json.lat self.lat
      json.lon self.lon
      json.interview_ja self.interview_ja
      json.interview_vn self.interview_vn
      json.interview_en self.interview_en
      json.sns_line self.sns_line
      json.sns_zalo self.sns_zalo
      json.sns_wechat self.sns_wechat
      json.is_credit self.is_credit
      json.is_japanese self.is_japanese
      json.is_english self.is_english
      json.is_chinese self.is_chinese
      json.is_korean self.is_korean
      json.tip self.tip
      json.girls_count self.girls_count
      json.is_smoked self.is_smoked
      json.opened_at self.opened_at
      json.closed_at self.closed_at
      json.budget_yen self.budget_yen
      json.budget_vnd self.budget_vnd
      json.budget_usd self.budget_usd
      json.service self.service
      json.user_count self.users.count
      # json.note self.note
      json.images self.abc
      json.tags self.tags ? Tag.to_jbuilders(self.tags) : nil
    end
  end

  def images=(images_base64)
    if !images_base64.nil?
      images_base64.each do |value|
        image = self.images.new
        image.image = value and image.save! if value != ''
      end
    end
  end
  def abc
    self.images.map {|img|{id:img.id,url:img.image.url}}
  end


end
