class Group < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many  :images, class_name: 'ImageType::Group', as: :subject, dependent: :destroy, :autosave => true
  has_many :users

  has_many  :contacts, class_name: 'ContactType::GroupDetail', as: :subject, dependent: :destroy, :autosave => true
  has_many  :supports, class_name: 'PostType::Support', as: :receiver, dependent: :destroy, :autosave => true
  has_many  :favorites, class_name: 'PostType::Favorite', as: :receiver, dependent: :destroy, :autosave => true
  has_many  :reviews, class_name: 'ReviewType::Group', as: :receiver, dependent: :destroy, :autosave => true

  has_many  :top_pickups, class_name: 'PickupType::Top', as: :subject, dependent: :destroy, :autosave => true
  has_many  :puth_pickups, class_name: 'PickupType::Push', as: :subject, dependent: :destroy, :autosave => true

  has_many  :top_banners, class_name: 'BannerType::Top', as: :subject, dependent: :destroy, :autosave => true
  has_many  :top_side_pickups, class_name: 'BannerType::TopSide', as: :subject, dependent: :destroy, :autosave => true

  has_many  :karaoke_banners, class_name: 'BannerType::Top', as: :subject, dependent: :destroy, :autosave => true
  has_many  :massage_pickups, class_name: 'BannerType::TopSide', as: :subject, dependent: :destroy, :autosave => true
  has_many  :bar_pickups, class_name: 'BannerType::TopSide', as: :subject, dependent: :destroy, :autosave => true

  acts_as_taggable_on :labels
  acts_as_taggable


  def self.to_jbuilders(groups)
    Jbuilder.new do |json|
      json.array! groups do |group|
        json.id group.id
        json.name group.name
        json.name_kana group.name_kana
        json.job_type group.job_type
        json.tel group.tel
        json.email group.email
        json.address group.address
        json.lat group.lat
        json.lon group.lon
        json.interview_ja group.interview_ja
        json.interview_vn group.interview_vn
        json.interview_en group.interview_en
        json.sns_line group.sns_line
        json.sns_zalo group.sns_zalo
        json.sns_wechat group.sns_wechat
        json.is_credit group.is_credit
        json.is_japanese group.is_japanese
        json.is_english group.is_english
        json.is_chinese group.is_chinese
        json.is_korean group.is_korean
        json.score group.score
        json.chip group.chip
        json.girls_count group.girls_count
        json.is_smoked group.is_smoked
        json.opened_at group.opened_at
        json.closed_at group.closed_at
        json.budget_yen group.budget_yen
        json.budget_vnd group.budget_vnd
        json.budget_usd group.budget_usd
        json.note group.note
        json.images group.abc
        json.tags group.tag_list ? group.tag_list : nil
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
      json.chip self.chip
      json.girls_count self.girls_count
      json.is_smoked self.is_smoked
      json.opened_at self.opened_at
      json.closed_at self.closed_at
      json.budget_yen self.budget_yen
      json.budget_vnd self.budget_vnd
      json.budget_usd self.budget_usd
      json.note self.note
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
