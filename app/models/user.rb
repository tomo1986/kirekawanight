class User < ApplicationRecord

  belongs_to :shop
  has_one :ja_profile, class_name: 'ProfileType::Ja', dependent: :destroy, :autosave => true
  has_one :vn_profile, class_name: 'ProfileType::Vn', dependent: :destroy, :autosave => true
  has_one :en_profile, class_name: 'ProfileType::En', dependent: :destroy, :autosave => true

  has_many :user_profiles
  has_many  :images, class_name: 'ImageType::User', as: :subject, dependent: :destroy, :autosave => true
  has_many  :page_views, class_name: 'PageViewType::UserDetail', as: :subject, dependent: :destroy, :autosave => true
  # has_many  :supports, class_name: 'SupportType::UserDetail', as: :subject, dependent: :destroy, :autosave => true
  has_many  :contacts, class_name: 'ContactType::UserDetail', as: :subject, dependent: :destroy, :autosave => true
  has_many  :supports, class_name: 'PostType::Support', as: :receiver, dependent: :destroy, :autosave => true
  has_many  :favorites, class_name: 'PostType::Favorite', as: :receiver, dependent: :destroy, :autosave => true
  has_many  :reviews, class_name: 'ReviewType::User', as: :receiver, dependent: :destroy, :autosave => true

  has_many  :top_pickups, class_name: 'PickupType::Top', as: :subject, dependent: :destroy, :autosave => true
  has_many  :puth_pickups, class_name: 'PickupType::Push', as: :subject, dependent: :destroy, :autosave => true

  has_many  :top_banners, class_name: 'BannerType::Top', as: :subject, dependent: :destroy, :autosave => true
  has_many  :top_side_pickups, class_name: 'BannerType::TopSide', as: :subject, dependent: :destroy, :autosave => true
  has_many  :karaoke_banners, class_name: 'BannerType::Karaoke', as: :subject, dependent: :destroy, :autosave => true
  has_many  :massage_pickups, class_name: 'BannerType::Massage', as: :subject, dependent: :destroy, :autosave => true
  has_many  :bar_pickups, class_name: 'BannerType::Bar', as: :subject, dependent: :destroy, :autosave => true

  acts_as_taggable_on :labels
  acts_as_taggable



  scope :keyword_filter, ->(keyword=nil) {
    users = self
    if keyword && keyword.strip.length > 0
      tokens = keyword.gsub('　', ' ').split(' ').collect {|c| "%#{c.downcase}%"}
      arrColumns = ["`users`.`sns_line`","`users`.`sns_zalo`","`users`.`sns_wechat`","`users`.`birthplace`"]# define column search in this array
      users = users.where(((["CONCAT_WS(' ', " + arrColumns.join(', ') + ') LIKE ?']*tokens.size).join(' AND ')),*(tokens).collect{ |token| [token] }.flatten)
    end
  }
  scope :job_type_filter, -> (opt_type= nil) {
    return if opt_type.blank?
    return self.where(shops: {job_type: opt_type})
  }
  scope :sex_filter, -> (opt_sex= nil) {
    return if opt_sex.blank?
    return self.where(users: {sex: opt_sex})
  }
  scope :sort_new, -> (order= 'desc'){
    return self.order("created_at #{order}")
  }
  scope :sort_support, -> (order= 'desc'){
    return self.joins("left join posts on posts.receiver_id = users.id and posts.type = 'PostType::Support' and posts.receiver_type = 'User'").group("users.id")
               .order("count(posts.receiver_id) #{order}, users.id desc")
  }
  scope :sort_favorite, -> (order= 'desc'){
    return self.joins("left join posts on posts.receiver_id = users.id and posts.type = 'PostType::Favorite' and posts.receiver_type = 'User'").group("users.id")
               .order("count(posts.receiver_id) #{order}, users.id desc")
  }
  scope :find_new_user, -> (){
    now = Time.zone.now
    return self.where(created_at: now.beginning_of_month...now.end_of_month).limit(5).sort_new
  }
  scope :find_open, -> () {
    return self.where(deleted_at: nil)
  }



  def age
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - self.birthday.strftime(date_format).to_i) / 10000
  end

  def change_lang_job_type_at_ja
    return 'カラオケ' if self.job_type == "karaoke"
    return 'ガールズバー' if self.job_type == "bar"
    return 'マッサージ' if self.job_type == "massage"
    return 'xxx' if self.job_type == "sexy"
  end

  def self.avg_user_score
    users =  User.where(deleted_at:nil)
    users.each do |user|
      count = user.reviews.count
      reviews = user.reviews.where(is_displayed: true)
      user.score1 = reviews.sum(:score1) > 0 ? (reviews.sum(:score1) / count).round(1) : 0
      user.score2 = reviews.sum(:score2) > 0 ? (reviews.sum(:score2) / count).round(1) : 0
      user.score3 = reviews.sum(:score3) > 0 ? (reviews.sum(:score3) / count).round(1) : 0
      user.score4 = reviews.sum(:score4) > 0 ? (reviews.sum(:score4) / count).round(1) : 0
      user.score5 = reviews.sum(:score5) > 0 ? (reviews.sum(:score5) / count).round(1) : 0
      user.total_score = reviews.sum(:total_score) > 0 ? (reviews.sum(:total_score) / count).round(1) : 0
      user.save!
    end
  end

  def self.score_ranking
    ["karaoke","bar","massage"].each do |job|
      before_user = nil
      users =  User.where(deleted_at:nil,job_type: job).order("total_score desc")
      users.each.with_index(1) do |user,i|
        if before_user
          if before_user.total_score != user.total_score
            user.ranking = i
            user.save!
            before_user = user
          else
            user.ranking = before_user.ranking
            user.save!
            before_user = user
          end
        else
          user.ranking = i
          user.save!
          before_user = user
        end
      end
    end
  end



  def self.to_jbuilders(users)
    Jbuilder.new do |json|
      json.array! users do |user|
        json.id user.id
        json.name user.name
        json.nick_name user.nick_name
        json.birthday user.birthday
        json.age user.birthday ? user.age : '-'
        json.height user.height ? user.height : '-'
        json.weight user.weight ? user.weight : '-'
        json.bust user.bust
        json.bust_size user.bust_size
        json.waist user.waist
        json.hip user.hip
        json.can_guided user.can_guided
        json.japanese_level user.japanese_level
        json.dayly_count PageView.counts_period(user.page_views)
        json.weekly_count PageView.counts_period(user.page_views,Time.zone.now.beginning_of_week,Time.zone.now.end_of_week)
        json.monthly_count PageView.counts_period(user.page_views,Time.zone.now.beginning_of_month,Time.zone.now.end_of_month)
        json.support_count user.supports.count
        json.favorite_count user.favorites.count
        json.contact_count user.contacts.count
        json.images user.abc
        json.shop user.shop ? user.shop.to_jbuilder : nil
        json.tags user.tag_list ? user.tag_list : nil
      end
    end
  end

  def self.to_jbuilders2(users)
    Jbuilder.new do |json|
      json.array! users do |user|
        json.id user.id
        json.name user.name
        json.nick_name user.nick_name
        json.birthday user.birthday
        json.set! :body do
          json.height user.height
          json.weight user.weight
          json.bust user.bust
          json.bust_size user.bust_size
          json.waist user.waist
          json.hip user.hip
        end
        json.images user.abc
      end
    end
  end


  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.shop_id self.shop_id
      json.name self.name
      json.nick_name self.nick_name
      json.birthplace self.birthplace
      json.residence self.residence
      json.birthday self.birthday
      json.age self.birthday ? self.age : '秘密'
      json.constellation self.constellation
      json.job_type self.job_type
      json.blood_type self.blood_type
      json.sex self.sex
      json.sns_line self.sns_line
      json.sns_zalo self.sns_zalo
      json.sns_wechat self.sns_wechat
      json.height self.height
      json.weight self.weight
      json.bust self.bust
      json.bust_size self.bust_size
      json.waist self.waist
      json.hip self.hip
      json.can_guided self.can_guided
      json.japanese_level self.japanese_level
      json.is_japanese self.is_japanese
      json.is_english self.is_english
      json.is_chinese self.is_chinese
      json.is_korean self.is_korean
      json.images self.abc
      json.support_count self.supports.count
      json.favorite_count self.favorites.count
      json.contact_count self.contacts.count
      json.shop self.shop ? self.shop.to_jbuilder : nil
      json.ja self.ja_profile ? self.ja_profile.to_jbuilder : UserProfile.new.to_jbuilder
      json.vn self.vn_profile ? self.vn_profile.to_jbuilder : UserProfile.new.to_jbuilder
      json.en self.en_profile ? self.en_profile.to_jbuilder : UserProfile.new.to_jbuilder
      json.tags self.tag_list ? self.tag_list : nil
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
