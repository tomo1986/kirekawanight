class Shop < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :group

  has_many  :images, class_name: 'ImageType::Shop', as: :subject, dependent: :destroy, :autosave => true
  has_many  :way_images, class_name: 'ImageType::ShopWay', as: :subject, dependent: :destroy, :autosave => true

  has_many :users
  has_many :basic_menus, class_name: 'MenuType::Basic', dependent: :destroy, :autosave => true
  has_many :drink_menus, class_name: 'MenuType::Drink', dependent: :destroy, :autosave => true
  has_many :food_menus, class_name: 'MenuType::Food', dependent: :destroy, :autosave => true

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

  scope :global_search, ->(sort=nil,job=nil,tags=nil,budget=nil,mama_tip=nil,tip=nil,charge=nil,karaoke_machine=nil,japanese=nil,english=nil){
    now = Time.zone.now
    shops = Shop.joins(
        "left join taggings on shops.id = taggings.taggable_id and taggable_type = 'Shop' left join pickups on shops.id = pickups.subject_id and pickups.type = 'PickupType::Push' and pickups.subject_type = 'Shop' and shops.deleted_at is null "
    ).uniq
    if sort == 'new'
      shops = shops.where("(shops.job_type = ? and (pickups.start_at <= ? and pickups.end_at > ?)) or (shops.job_type = ?) ",job, now,now, job).order("pickups.number_place is null asc, pickups.number_place asc")
    else
      shops = shops.where(job_type: job,deleted_at: nil)
    end

    if sort == 'new'
      shops = shops.sort_new('desc')
    elsif sort == 'support'
      shops = shops.sort_support('desc')
    elsif sort == 'favorite'
      shops = shops.sort_favorite('desc')
    elsif sort == 'ranking'
      shops = shops.sort_ranking('desc')
    elsif sort == 'review'
      shops = shops.sort_review('desc')
    end

    if tags && tags.length > 0
      sql = ""
      count = tags.length
      if count > 1
        tags.each.with_index(1) do |tag,i|
          sql = sql + "taggings.tag_id = #{tag} "
          sql = sql + "or " if count > i
        end
      else
        sql = sql + "taggings.tag_id = #{tags.to_i}" if tags.to_i != 0
      end
      shops = shops.where(sql) if sql.present?
    end

    if budget
      shops = shops.where("shops.budget_vnd >= 300000 and shops.budget_vnd < 500000") if budget.to_i == 1
      shops = shops.where("shops.budget_vnd >= 600000 and shops.budget_vnd < 800000") if budget.to_i == 2
      shops = shops.where("shops.budget_vnd >= 900000 and shops.budget_vnd < 1200000") if budget.to_i == 3
      shops = shops.where("shops.budget_vnd >= 1300000 and shops.budget_vnd < 1500000") if budget.to_i == 4
    end
    shops = shops.where("shops.mama_tip = false") if mama_tip
    shops = shops.where("shops.tip = false") if tip
    shops = shops.where("shops.charge = false") if charge
    shops = shops.where("shops.karaoke_machine = true") if karaoke_machine
    shops = shops.where("shops.is_japanese = true") if japanese
    shops = shops.where("shops.is_english = true") if english

    return shops

  }




  scope :keyword_filter, ->(keyword=nil) {
    shops = self.joins('left join users on users.shop_id = shops.id left join groups on shops.group_id = groups.id')
    if keyword && keyword.strip.length > 0
      tokens = keyword.gsub('　', ' ').split(' ').collect {|c| "%#{c.downcase}%"}
      arrColumns = ["`shops`.`name`","`shops`.`name_kana`"]# define column search in this array
      shops = shops.where(((["CONCAT_WS(' ', " + arrColumns.join(', ') + ') LIKE ?']*tokens.size).join(' AND ')),*(tokens).collect{ |token| [token] }.flatten)
    end
    return shops
  }

  scope :find_girls_count, -> (count) {
    return self.where("shops.girls_count >= ?", count)
  }

  scope :find_user_card, -> () {
    return self.where("shops.is_card = ?", true)
  }
  scope :find_tip, -> (tip) {
    return self.where("shops.tip = ?", tip)
  }



  scope :find_open, -> () {
    return self.where(deleted_at: nil)
  }

  scope :sort_new, -> (order= 'desc'){
    return self.order("shops.created_at #{order}")
  }
  scope :sort_support, -> (order= 'desc'){
    return self.joins("left join posts on posts.receiver_id = shops.id and posts.type = 'PostType::Support' and posts.receiver_type = 'Shop'").group("shops.id")
               .order("count(posts.receiver_id) #{order}, shops.id desc")
  }
  scope :sort_favorite, -> (order= 'desc'){
    return self.joins("left join posts on posts.receiver_id = shops.id and posts.type = 'PostType::Favorite' and posts.receiver_type = 'Shop'").group("shops.id")
               .order("count(posts.receiver_id) #{order}, shops.id desc")
  }
  scope :sort_review, -> (order= 'desc'){
    return self.joins("left join reviews on reviews.receiver_id = shops.id and reviews.type = 'ReviewType::Shop' and reviews.receiver_type = 'Shop'").group("shops.id")
               .order("count(reviews.receiver_id) #{order}, shops.id desc")
  }

  scope :sort_ranking, -> (order= 'desc'){
    return self.order("shops.total_score #{order}")
  }

  def open_discounts
    now = Time.zone.now
    return self.time_discounts.where('start_at <= ? and end_at > ?',now, now)
  end

  def self.make_daily_authentication_code
    shops =  Shop.where(deleted_at:nil)
    shops.each do |shop|
      code = (("a".."z").to_a + (0..9).to_a).shuffle[0..3].join
      shop.authentication_code = code unless Shop.exists?(authentication_code: code)
      shop.save!
    end
  end

  def self.avg_shop_score
    shops =  Shop.where(deleted_at:nil)
    shops.each do |shop|
      count = shop.reviews.where(reviews:{is_displayed: true}).count
      reviews = shop.reviews.where(reviews:{is_displayed: true})
      shop.score1 = reviews.sum(:score1) > 0 ? (reviews.sum(:score1) / count).round(1) : 0
      shop.score2 = reviews.sum(:score2) > 0 ? (reviews.sum(:score2) / count).round(1) : 0
      shop.score3 = reviews.sum(:score3) > 0 ? (reviews.sum(:score3) / count).round(1) : 0
      shop.score4 = reviews.sum(:score4) > 0 ? (reviews.sum(:score4) / count).round(1) : 0
      shop.score5 = reviews.sum(:score5) > 0 ? (reviews.sum(:score5) / count).round(1) : 0
      shop.total_score = reviews.sum(:total_score) > 0 ? (reviews.sum(:total_score) / count).round(1) : 0
      shop.save!
    end
  end
  def self.score_ranking
    ["karaoke","bar","massage"].each do |job|
      before_shop = nil
      shops =  Shop.where(deleted_at:nil,job_type: job).order("total_score desc")
      shops.each.with_index(1) do |shop,i|
        if before_shop
          if before_shop.total_score != shop.total_score
            shop.ranking = i
            shop.save!
            before_shop = shop
          else
            shop.ranking = before_shop.ranking
            shop.save!
            before_shop = shop
          end
        else
          shop.ranking = i
          shop.save!
          before_shop = shop
        end
      end
    end
  end


  def self.to_jbuilders(shops)
    Jbuilder.new do |json|
      json.array! shops do |shop|
        json.id shop.id
        json.group_id shop.group_id
        json.admin_id shop.admin_id
        json.staff shop.admin_id ? Admin.find_by(id: shop.admin_id) : nil
        json.name shop.name
        json.contract_person shop.contract_person
        json.name_kana shop.name_kana
        json.job_type shop.job_type
        json.tel shop.tel
        json.email shop.email
        json.address shop.address
        json.lat shop.lat
        json.lon shop.lon
        json.total_score shop.total_score
        json.ranking shop.ranking
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
        json.tip shop.tip
        json.deleted_at shop.deleted_at
        json.girls_count shop.girls_count
        json.is_smoked shop.is_smoked
        json.opened_at shop.opened_at
        json.closed_at shop.closed_at
        json.budget_yen shop.budget_yen
        json.budget_vnd shop.budget_vnd
        json.budget_usd shop.budget_usd
        json.one_point shop.one_point
        json.charge shop.charge
        json.mama_tip shop.mama_tip
        json.karaoke_machine shop.karaoke_machine
        json.catch_copy shop.catch_copy
        json.access shop.access
        json.tip_avg shop.tip_avg
        json.service shop.service
        json.ranking shop.ranking
        json.total_score shop.total_score
        json.user_count shop.users.count
        json.room_count shop.room_count
        json.seat_count shop.seat_count
        json.images shop.set_images
        json.support_count shop.supports.count
        json.favorite_count shop.favorites.count
        json.review_count shop.reviews.where(reviews:{is_displayed: true}).count
        json.is_new shop.new_shop?
        json.tags shop.tags ? Tag.to_jbuilders(shop.tags) : nil
      end
    end
  end

  def new_shop?
    now = Time.zone.now
    if self.created_at >= now - 1.months
      return true
    else
      return false
    end
  end

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.group_id self.group_id
      json.admin_id self.admin_id
      json.staff self.admin_id ? Admin.find_by(id: self.admin_id) : nil
      json.name self.name
      json.name_kana self.name_kana
      json.contract_person self.contract_person
      json.job_type self.job_type
      json.tel self.tel
      json.email self.email
      json.address self.address
      json.lat self.lat
      json.lon self.lon
      json.total_score self.total_score
      json.ranking self.ranking
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
      json.one_point self.one_point
      json.charge self.charge
      json.mama_tip self.mama_tip
      json.karaoke_machine self.karaoke_machine

      json.room_count self.room_count
      json.seat_count self.seat_count
      json.catch_copy self.catch_copy
      json.access self.access
      json.tip_avg self.tip_avg
      json.service self.service
      json.user_count self.users.count
      json.deleted_at self.deleted_at
      # json.note self.note
      json.images self.set_images
      json.way_images self.set_way_images
      json.drink_menus self.drink_menus
      json.food_menus self.food_menus
      json.basic_menus self.basic_menus
      json.support_count self.supports.count
      json.favorite_count self.favorites.count
      json.review_count self.reviews.where(reviews:{is_displayed: true}).count

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

  def way_images=(images_base64)
    if !images_base64.nil?
      images_base64.each do |value|
        image = self.way_images.new
        image.image = value and image.save! if value != ''
      end
    end
  end

  def set_images
    self.images.map {|img|{id:img.id,url:img.image.url}}
  end

  def set_way_images
    self.way_images.map {|img|{id:img.id,url:img.image.url}}
  end

end
