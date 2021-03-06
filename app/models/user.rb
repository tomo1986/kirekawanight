class User < ApplicationRecord

  belongs_to :shop
  has_one :ja_profile, class_name: 'ProfileType::Ja', dependent: :destroy, :autosave => true
  has_one :vn_profile, class_name: 'ProfileType::Vn', dependent: :destroy, :autosave => true
  has_one :en_profile, class_name: 'ProfileType::En', dependent: :destroy, :autosave => true
  has_one :twitter, class_name: 'MediaType::Twitter', as: :subject, dependent: :destroy, :autosave => true
  has_one :youtube, class_name: 'MediaType::Youtube', as: :subject, dependent: :destroy, :autosave => true
  has_many :user_profiles
  has_many  :images, class_name: 'ImageType::User', as: :subject, dependent: :destroy, :autosave => true
  has_many  :face_images, class_name: 'ImageType::UserAll', as: :subject, dependent: :destroy, :autosave => true
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

  scope :global_search, ->(sort=nil,job=nil,tags=nil,bust=nil){
    now = Time.zone.now
    users = User.joins(
        "left join taggings on users.id = taggings.taggable_id and taggable_type = 'User' left join pickups on users.id = pickups.subject_id and pickups.type = 'PickupType::Push' and pickups.subject_type = 'User' and users.deleted_at is null "
    ).distinct
    if sort == 'new'
      users = users.where("(users.job_type = ? and (pickups.start_at <= ? and pickups.end_at > ?)) or (users.job_type = ?) ",job, now,now, job).order("pickups.number_place is null asc, pickups.number_place asc")
    else
      users = users.where(job_type: job,deleted_at: nil)
    end

    if sort == 'new'
      users = users.sort_new('desc')
    elsif sort == 'support'
      users = users.sort_support('desc')
    elsif sort == 'favorite'
      users = users.sort_favorite('desc')
    elsif sort == 'ranking'
      users = users.sort_ranking('desc')
    elsif sort == 'review'
      users = users.sort_review('desc')
    end

    if tags && tags.length > 0
      sql = ""
      tag_object = tags.kind_of?(String)
      count = tags.length
      if count > 1 && !tag_object
        tags.each.with_index(1) do |tag,i|
          sql = sql + "users.id in(select taggable_id from taggings where tag_id = #{tag} and taggable_type = 'User' ) "
          sql = sql + "and " if count > i
        end
      else
        sql = sql + "taggings.tag_id = #{tags.to_i}" if tags.to_i != 0
      end
      users = users.where(sql) if sql.present?
    end

    return users

  }



  scope :keyword_filter, ->(keyword=nil,group_id=nil, shop_id=nil, job_type=nil) {
    users = self.joins('left join shops on users.shop_id = shops.id left join groups on shops.group_id = groups.id')
    if keyword && keyword.strip.length > 0
      tokens = keyword.gsub('　', ' ').split(' ').collect {|c| "%#{c.downcase}%"}
      arrColumns = ["`users`.`name`","`users`.`nick_name`","`shops`.`name`"]# define column search in this array
      users = users.where(((["CONCAT_WS(' ', " + arrColumns.join(', ') + ') LIKE ?']*tokens.size).join(' AND ')),*(tokens).collect{ |token| [token] }.flatten)
    end
    if group_id
      users = users.where(shops:{group_id: group_id} )
    end
    if shop_id
      users = users.where(users:{shop_id: shop_id} )
    end
    if job_type
      users = users.where(users:{job_type: job_type} )
    end
    return users
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
    return self.order("(select count(posts.receiver_id) from posts where posts.receiver_id = users.id and posts.type = 'PostType::Support' and posts.receiver_type = 'User' ) desc, users.id")
  }
  scope :sort_favorite, -> (order= 'desc'){
    return self.order("(select count(posts.receiver_id) from posts where posts.receiver_id = users.id and posts.type = 'PostType::Favorite' and posts.receiver_type = 'User' ) desc, users.id")
  }
  scope :sort_review, -> (order= 'desc'){
    return self.order("(select count(reviews.receiver_id) from reviews where reviews.receiver_id = users.id and reviews.type = 'ReviewType::User' and reviews.receiver_type = 'User' ) desc, users.id")
  }
  scope :sort_ranking, -> (order= 'desc'){
    return self.order("users.total_score #{order}")
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
        json.job_type user.job_type
        json.ranking user.ranking
        json.total_score user.total_score
        json.can_guided user.can_guided
        json.deleted_at user.deleted_at
        json.japanese_level user.japanese_level
        json.is_pickuped user.is_pickuped
        json.one_point user.one_point
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
  def self.to_jbuilders_for_admin(users)
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
        json.job_type user.job_type
        json.ranking user.ranking
        json.total_score user.total_score
        json.can_guided user.can_guided
        json.deleted_at user.deleted_at
        json.japanese_level user.japanese_level
        json.is_pickuped user.is_pickuped
        json.one_point user.one_point
        json.blood_type user.blood_type
        json.dayly_count PageView.counts_period(user.page_views)
        json.weekly_count PageView.counts_period(user.page_views,Time.zone.now.beginning_of_week,Time.zone.now.end_of_week)
        json.monthly_count PageView.counts_period(user.page_views,Time.zone.now.beginning_of_month,Time.zone.now.end_of_month)
        json.support_count user.supports.count
        json.favorite_count user.favorites.count
        json.contact_count user.contacts.count
        json.images user.abc
        json.face_images user.set_face_images
        json.shop user.shop ? user.shop.to_jbuilder : nil
        json.tags user.tag_list ? user.tag_list : nil
      end
    end
  end

  def self.to_jbuilders_for_user_list(users)
    Jbuilder.new do |json|
      json.array! users do |user|
        json.id user.id
        json.name user.name
        json.nick_name user.nick_name
        json.height user.height ? user.height : '-'
        json.weight user.weight ? user.weight : '-'
        json.bust user.bust
        json.bust_size user.bust_size
        json.waist user.waist
        json.hip user.hip
        json.job_type user.job_type
        json.ranking user.ranking
        json.total_score user.total_score
        json.is_pickuped user.is_pickuped
        json.favorite_count user.favorites.count
        json.contact_count user.contacts.count
        json.birthday user.birthday
        json.age user.birthday ? user.age : '-'
        json.images user.abc
        json.set! :shop do
          json.id user.shop ? user.shop.id : nil
          json.name user.shop ? user.shop.name : nil
        end
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
      json.age self.birthday ? self.age : nil
      json.constellation self.constellation
      json.job_type self.job_type
      json.blood_type self.blood_type
      json.sex self.sex
      json.height self.height
      json.weight self.weight
      json.bust self.bust
      json.bust_size self.bust_size
      json.waist self.waist
      json.hip self.hip
      json.ranking self.ranking
      json.total_score self.total_score
      json.can_guided self.can_guided
      json.one_point self.one_point
      json.japanese_level self.japanese_level
      json.is_japanese self.is_japanese
      json.is_english self.is_english
      json.is_pickuped self.is_pickuped
      json.images self.abc
      json.support_count self.supports.count
      json.favorite_count self.favorites.count
      json.contact_count self.contacts.count
      json.shop self.shop ? self.shop.to_jbuilder : nil
      json.profile self.ja_profile ? self.ja_profile.to_jbuilder : UserProfile.new.to_jbuilder
      json.twitter self.twitter ? self.twitter.to_jbuilder : nil
      json.youtube self.youtube ? self.youtube.to_jbuilder : nil
      json.tags self.tag_list ? self.tag_list : nil
    end
  end
  def to_jbuilder_for_admin
    Jbuilder.new do |json|
      json.id self.id
      json.shop_id self.shop_id
      json.name self.name
      json.nick_name self.nick_name
      json.birthplace self.birthplace
      json.residence self.residence
      json.birthday self.birthday
      json.age self.birthday ? self.age : nil
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
      json.ranking self.ranking
      json.deleted_at self.deleted_at
      json.total_score self.total_score
      json.can_guided self.can_guided
      json.one_point self.one_point
      json.japanese_level self.japanese_level
      json.is_japanese self.is_japanese
      json.is_english self.is_english
      json.is_chinese self.is_chinese
      json.is_korean self.is_korean
      json.is_pickuped self.is_pickuped
      json.images self.abc
      json.face_images self.set_face_images
      json.support_count self.supports.count
      json.favorite_count self.favorites.count
      json.contact_count self.contacts.count
      json.shop self.shop ? self.shop.to_jbuilder : nil
      json.ja self.ja_profile ? self.ja_profile.to_jbuilder : UserProfile.new.to_jbuilder
      json.twitter self.twitter ? self.twitter.to_jbuilder : Media.new.to_jbuilder
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

  def face_images=(images_base64)
    if !images_base64.nil?
      images_base64.each do |value|
        image = self.face_images.new
        image.image = value and image.save! if value != ''
      end
    end
  end

  def set_face_images
    self.face_images.map {|img|{id:img.id,url:img.image.url}}
  end

end
