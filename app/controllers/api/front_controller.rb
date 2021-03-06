require 'net/https'
require 'net/http'
require 'uri'

class Api::FrontController < ApiController

  def logout
    sign_out(current_customer) if customer_signed_in?
    builder = Jbuilder.new do |json|
      json.code 1
      json.custommer nil
    end
    render json: builder.target!
  end

  def change_password
    email = params[:email]
    password = params[:password]
    render_failed(4, t('customer.error.not_find')) and return if email.blank? || password.blank?
    customer = Customer.where(:email => params[:email]).first
    customer.password = password
    if customer.save!
      builder = Jbuilder.new do |json|
        json.code 1
        json.customer customer.to_jbuilder
      end

    end

    render json: builder.target!

  end

  def connect
    if customer_signed_in?
      builder = Jbuilder.new do |json|
        json.code 1
        json.customer current_customer.to_jbuilder
      end
    else
      builder = Jbuilder.new do |json|
        json.code 0
        json.customer nil
      end
    end
    render json: builder.target!
  end

  def all_users
    users = User.where(deleted_at: nil)
    builders = Jbuilder.new do |json|
      json.users User.to_jbuilders(users)
    end
    render json: builders.target!

  end

  def all_shops
    shops = Shop.where(deleted_at: nil)
    builders = Jbuilder.new do |json|
      json.shops Shop.to_jbuilders(shops)
    end
    render json: builders.target!

  end

  def all_groups
    groups = Group.where(deleted_at: nil)
    builders = Jbuilder.new do |json|
      json.groups Group.to_jbuilders(groups)
    end
    render json: builders.target!
  end

  def all_tags
    tags = Tag.all
    builders = Jbuilder.new do |json|
      json.tags Tag.to_jbuilders(tags)
    end
    render json: builders.target!
  end

  def shop_tags
    tags = Tag.joins(:taggings).where(taggings:{taggable_type:'Shop'}).uniq
    builders = Jbuilder.new do |json|
      json.tags Tag.to_jbuilders(tags)
    end
    render json: builders.target!
  end

  def user_tags
    tags = Tag.joins(:taggings).where(taggings:{taggable_type:'User'}).uniq
    builders = Jbuilder.new do |json|
      json.tags Tag.to_jbuilders(tags)
    end
    render json: builders.target!
  end


  def api0
    email = params[:email]
    password = params[:password]
    render_failed(4, t('customer.error.not_find')) and return if email.blank? || password.blank?
    customer = Customer.where(:email => params[:email]).first
    render_failed(4, t('customer.error.not_find')) and return  unless customer && customer.valid_password?(params[:password])
    customer.remember_me = params[:remember_me]
    sign_in customer
    builder = Jbuilder.new do |json|
      json.code 1
      json.customer customer.to_jbuilder
    end
    render json: builder.target!

  end

  def api1
    PageViewType::Top.create
  end

  def api2
    if params[:job_type] == 'karaoke'
      PageViewType::CastKaraoke.create
    elsif params[:job_type] == 'bar'
      PageViewType::CastBar.create
    elsif params[:job_type] == 'massage'
      PageViewType::CastMassage.create
    elsif params[:job_type] == 'sexy'
      PageViewType::CastSexy.create
    end
    # users = User.global_search(params[:sort],params[:job_type],params[:tags],params[:bust])

    users = User.where(job_type: params[:job_type]).order("id desc")
    users = users.where(users:{deleted_at: nil})
    total = users.count

    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    users = users.page(page).per(limit) if users.present?
    now = Time.zone.now
    # push_users = User.joins("join pickups on users.id = pickups.subject_id and pickups.type = 'PickupType::Push' and pickups.subject_type = 'User'").where("users.job_type = ? and (pickups.start_at <= ? and pickups.end_at > ?)",params[:job_type], now,now).order("pickups.number_place asc")
    supports = {}
    favorites = {}
    if customer_signed_in?
      customer = Customer.find_by(id: current_customer.id)
      customer.supports.each do |support|
        supports[support.receiver_id] = support
      end
      customer.favorites.each do |favorite|
        favorites[favorite.receiver_id] = favorite
      end
    end

    builders = Jbuilder.new do |json|
      json.users User.to_jbuilders_for_user_list(users)
      json.supports supports
      json.favorites favorites
      json.total total
    end
    render json: builders.target!

  end
  def api3
    PageViewType::UserDetail.create(subject_type: 'User',subject_id: params[:id])
    user = User.find_by(id: params[:id])
    is_favorited = false
    is_favorited = current_customer.favorites.exists?(receiver_type: 'User', receiver_id: params[:id]) if customer_signed_in?
    if user
      builder = Jbuilder.new do |json|
        json.code 1
        json.user user.to_jbuilder
        json.is_favorited is_favorited
      end
    else
      builder = Jbuilder.new do |json|
        json.error "キャストが存在しません"
      end
    end
    render json: builder.target!

  end
  def api4
    instagram_iamges = []

    PageViewType::ShopDetail.create(subject_type: 'Shop',subject_id: params[:id])
    shop = Shop.find_by(id: params[:id])
    render_failed(4, t('shop.error.not_find')) and return if shop.blank?
    users = shop.users.where(users:{deleted_at: nil})
    is_favorited = false
    is_favorited = current_customer.favorites.exists?(receiver_type: 'Shop', receiver_id: params[:id]) if customer_signed_in?
    favorites = {}
    if customer_signed_in?
      current_customer.favorites.each do |favorite|
        favorites[favorite.receiver_id] = favorite
      end
    end
    shops = Shop.where(group_id: shop.group_id, deleted_at: nil).where.not(id: shop.id) if shop.group_id
    pickup_users = shop.users.where(users:{is_pickuped: true}).limit(3) if shop.users
    now = Time.zone.now
    events = shop.events.where("events.started_at <= ? and events.end_at > ?",now,now)
    if shop.instagram
      begin
        uri = URI("https://api.instagram.com/v1/users/self/media/recent/")
        params = { :access_token => "#{shop.instagram.script}"}
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        if res
          instagrams = YAML::load(res.body)
          instagrams["data"].each do |data|
            instagram_iamges << {
                url: data["images"]["standard_resolution"]["url"],
                link: data["link"]
            }
          end
        end
      end
    end

    builder = Jbuilder.new do |json|
      json.code 1
      json.shop shop.to_front_jbuilder
      json.is_favorited is_favorited
      json.pickup_users pickup_users ? User.to_jbuilders_for_admin(pickup_users) : nil
      json.favorites favorites
      json.shops Shop.to_jbuilders(shops)
      json.all_shop_count Shop.where(job_type: shop.job_type,deleted_at:nil).count
      json.events Event.to_shop_events_jbuilders(events)
      json.instagrams instagram_iamges
    end
    render json: builder.target!
  end

  def api5
    message = ''
    if params[:type] == 'support'
      now = Time.zone.now
      if PostType::Support.where(sender_id: params[:sender_id], receiver_id: params[:receiver_id], created_at: now.beginning_of_day...now.end_of_day).count > 0
        title = '今日はすでに応援しています。'
        message = '1日1回応援できます。'
      else
        PostType::Support.create(sender_type:'Customer',sender_id:params[:sender_id],receiver_id:params[:receiver_id],receiver_type:params[:receiver_type])
        title = "応援ありがとうございます。"
        message = '1日1回応援できます。'
      end
    elsif params[:type] == 'favorite'
      if PostType::Favorite.where(sender_id: params[:sender_id], receiver_id: params[:receiver_id]).count > 0
        PostType::Favorite.where(sender_id: params[:sender_id], receiver_id: params[:receiver_id]).first.delete
        title = "お気に入りを削除しました。"
        message = 'お気に入りを削除しました。'
      else
        PostType::Favorite.create(sender_type:'Customer',sender_id:params[:sender_id],receiver_id:params[:receiver_id],receiver_type:params[:receiver_type])
        title = 'お気に入り登録しました。'
        message = 'お気に入り登録しました。'
      end
    elsif params[:type] == 'reference'
      if PostType::Reference.where(sender_id: params[:sender_id], receiver_id: params[:receiver_id]).count > 0
        title = "フィードバックを受け付けました。"
        message = 'フィードバックありがとうございます。'
      else
        PostType::Reference.create(sender_type:'Customer',sender_id:params[:sender_id],receiver_id:params[:receiver_id],receiver_type:params[:receiver_type])
        title = "フィードバックを受け付けました。"
        message = 'フィードバックありがとうございます。'
      end

    elsif params[:type] == 'not_reference'
      if PostType::NotReference.where(sender_id: params[:sender_id], receiver_id: params[:receiver_id]).count > 0
        title = "フィードバックを受け付けました。"
        message = 'フィードバックありがとうございます。'
      else
        PostType::NotReference.create(sender_type:'Customer',sender_id:params[:sender_id],receiver_id:params[:receiver_id],receiver_type:params[:receiver_type])
        title = "フィードバックを受け付けました。"
        message = 'フィードバックありがとうございます。'
      end

    end
    if params[:receiver_type] == 'User'
      user = User.find_by(id: params[:receiver_id])
      support_count = user.supports.count
      favorite_count = user.favorites.count
    elsif params[:receiver_type] == 'Shop'
      shop = Shop.find_by(id: params[:receiver_id])
      support_count = shop.supports.count
      favorite_count = shop.favorites.count

    end

    favorites = {}
    if customer_signed_in?
      customer = Customer.find_by(id: current_customer.id)
      customer.favorites.each do |favorite|
        favorites[favorite.receiver_id] = favorite
      end
    end
    is_favorited = false
    is_favorited = current_customer.favorites.exists?(receiver_type: params[:receiver_type], receiver_id: params[:receiver_id]) if customer_signed_in?

    builders = Jbuilder.new do |json|
      json.code 1
      json.title title
      json.message message
      json.favorites favorites
      json.is_favorited is_favorited
      json.support_count support_count
      json.favorite_count favorite_count
    end
    render json: builders.target!

  end

  def api6
    if params[:type] == 'user_detail'
      contact = ContactType::UserDetail.new
    elsif params[:type] == 'shop_detail'
      contact = ContactType::ShopDetail.new
    elsif  params[:type] == 'contact'
      contact = ContactType::Contact.new
    end

    contact.attributes = {
        subject_type: params[:subject_type],
        subject_id: params[:subject_id],
        name: params[:name],
        email: params[:email],
        tel: params[:tel],
        sns_line: params[:sns_line],
        sns_zalo: params[:sns_zalo],
        sns_wechat: params[:sns_wechat],
        message: params[:message],
        return_way: params[:return_way]
    }

    if contact.save!

      text = "レビューが書かれました。\n\n"
      if contact.subject_type == 'Shop'
        shop = Shop.find(contact.subject_id)
        text = text + "#{shop.name}\n"
        text = text + "#{root_url}shops/#{shop.job_type}/#{shop.id}/info\n"
        text = text + "連絡先折り返しは#{contact.return_way}で電話番号は#{contact.tel}\n"
        text = text + "#{contact.email}[line:#{contact.sns_line}zalo:#{contact.sns_zalo}wechat:#{contact.sns_wechat}]\n"
        text = text + "#{contact.message}"
      elsif contact.subject_type == 'User'
        user = User.find(contact.subject_id)
        text = text + "#{user.name}\n"
        text = text + "#{root_url}/casts/#{user.job_type}/#{user.id}/info\n"
        text = text + "連絡先折り返しは#{contact.return_way}で電話番号は#{contact.tel}\n"
        text = text + "#{contact.email}[line:#{contact.sns_line}zalo:#{contact.sns_zalo}wechat:#{contact.sns_wechat}]\n"
        text = text + "#{contact.message}"
      end


      host = "slack.com"
      path = "/api/chat.postMessage"
      query_parameter = {  "token" => "xoxp-109579077938-108903236561-118073279111-cdfee3063e0b9c1436ae480ca349784c",
                           "channel" => "#contact",
                           "text" => text,
                           "username" => "contact manager" }
      query = query_parameter.map do |key,value|
        "#{URI.encode(key)}=#{URI.encode(value)}"
      end.join("&")
      https = Net::HTTP.new(host, 443)
      https.use_ssl = true
      res = https.post(path, query)


      builder = Jbuilder.new do |json|
        json.contact contact.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors contact.errors.full_messages
        json.code 0
      end
    end
    render json: builder.target!
  end

  #New Customer create
  def api9
    email = params[:email]
    password = params[:password]
    render_failed(4, t('customer.error.not_params')) and return if email.blank? || password.blank?
    render_failed(4, t('customer.aleady')) and return if Customer.find_by(email: email)
    customer =Customer.new(email: email, password: password)
    if customer.save!
      sign_in customer
      builder = Jbuilder.new do |json|
        json.code 1
        json.customer customer.to_jbuilder
      end
      render json: builder.target!
    else
      render_failed(4, t('customer.not'))
    end
  end

  #login Customer API
  def api10
    email = params[:email]
    password = params[:password]
    render_failed(4, t('customer.error.not_params')) and return  if email.blank? || password.blank?
    customer = Customer.where(:email => params[:email]).first
    render_failed(4, t('customer.error.email_not_exist')) and return unless customer && customer.valid_password?(params[:password])

    session[:customer_id] = customer.id
    sign_in customer
    j_builder = customer.to_builder
    render_success(j_builder)
  end

  #Top page
  def api11
    if customer_signed_in?
      customer = Customer.find_by(id: current_customer.id)
      favorite_users = User.where(id: customer.favorites.pluck(:receiver_id))
    end
    users = User.all
    shops = Shop.where(deleted_at: nil)
    now = Time.zone.now
    from = now.beginning_of_month
    to = now.end_of_month
    favorites = {}
    if customer_signed_in?
      current_customer.favorites.each do |favorite|
        favorites[favorite.receiver_id] = favorite
      end
    end


    builders = Jbuilder.new do |json|
      json.favorites favorites
      json.new_karaoke_users User.to_jbuilders_for_user_list(users.where(job_type: 'karaoke').order("id desc").limit(4))
      json.new_bar_users User.to_jbuilders_for_user_list(users.where(job_type: 'bar').order("id desc").limit(4))
      json.new_massage_users User.to_jbuilders_for_user_list(users.where(job_type: 'massage').order("id desc").limit(4))
      json.new_karaoke_shops Shop.to_jbuilders_user_list(shops.where(job_type: 'karaoke').order("id desc").limit(4))
      json.new_bar_shops Shop.to_jbuilders_user_list(shops.where(job_type: 'bar').order("id desc").limit(4))
      json.new_massage_shops Shop.to_jbuilders_user_list(shops.where(job_type: 'massage').order("id desc").limit(4))
      json.time_services Discount.to_jbuilders(Discount.open_time_discounts)
      json.events Event.to_front_jbuilders(Event.limit(5))

    end
    render json: builders.target!
  end
  #shop list page
  def api12
    if params[:job_type] == 'karaoke'
      PageViewType::ShopKaraoke.create
    elsif params[:job_type] == 'bar'
      PageViewType::ShopBar.create
    elsif params[:job_type] == 'massage'
      PageViewType::ShopMassage.create
    elsif params[:job_type] == 'sexy'
      PageViewType::ShopSexy.create
    end
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    # shops = Shop.global_search(params[:sort],params[:job_type],params[:tags],params[:budget],params[:mama_tip],params[:tip],params[:charge],params[:karaoke_machine],params[:japanese],params[:english])
    shops = Shop.where(job_type: params[:job_type]).order("id desc")
    shops = shops.where(shops:{deleted_at: nil})
    total = shops.length

    shops = shops.page(page).per(limit) if shops.present?
    favorites = {}
    if customer_signed_in?
      customer = Customer.find_by(id: current_customer.id)
      customer.favorites.each do |favorite|
        favorites[favorite.receiver_id] = favorite
      end
    end

    builders = Jbuilder.new do |json|
      json.shops Shop.to_jbuilders_user_list(shops)
      json.favorites favorites
      json.total total
    end
    render json: builders.target!

  end


  def api13
    if params[:type] == 'shop'
      review = ReviewType::Shop.new
    elsif params[:type] == 'cast'
      review = ReviewType::User.new
    end

    review.attributes = {
        sender_type: params[:sender_type],
        sender_id: params[:sender_id],
        receiver_type: params[:receiver_type],
        receiver_id: params[:receiver_id],
        info1: params[:info1],
        info2: params[:info2],
        info3: params[:info3],
        info4: params[:info4],
        info5: params[:info5],
        score1: params[:score1].to_i * 4,
        score2: params[:score2].to_i * 4,
        score3: params[:score3].to_i * 4,
        score4: params[:score4].to_i * 4,
        score5: params[:score5].to_i * 4,
        title: params[:title],
        comment: params[:comment],
        opinion: params[:opinion],
        is_draft: params[:is_draft],
        is_displayed: false
    }


    if review.save!
      text = "レビューが書かれました。\n\n"
      if review.receiver_type == 'Shop'
        shop = Shop.find(review.receiver_id)
        text = text + "#{shop.name}\n"
        text = text + "#{root_url}shops/#{shop.job_type}/#{shop.id}/info\n"
        text = text + "スコア#{review.total_score}点\n"
        text = text + "タイトル:#{review.title}\n"
        text = text + "#{review.comment}"
      elsif review.receiver_type == 'User'
        user = User.find(review.receiver_id)
        text = text + "#{user.name}\n"
        text = text + "#{root_url}/casts/#{user.job_type}/#{user.id}/info\n"
        text = text + "スコア#{review.total_score}点\n"
        text = text + "#{review.comment}"
      end


      host = "slack.com"
      path = "/api/chat.postMessage"
      query_parameter = {  "token" => "xoxp-109579077938-108903236561-118073279111-cdfee3063e0b9c1436ae480ca349784c",
                           "channel" => "#review",
                           "text" => text,
                           "username" => "review manager" }
      query = query_parameter.map do |key,value|
        "#{URI.encode(key)}=#{URI.encode(value)}"
      end.join("&")
      https = Net::HTTP.new(host, 443)
      https.use_ssl = true
      res = https.post(path, query)



      builder = Jbuilder.new do |json|
        json.review review.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors review.errors.full_messages
        json.code 0
      end
    end
    render json: builder.target!
  end

  def api14

    render_failed(4, t('customer.error.not_params')) and return if Customer.find_by(email: params[:email])
    customer = Customer.new
    customer.attributes = {
        email: params[:email],
        password: params[:password]
    }
    if customer.save
      builder = Jbuilder.new do |json|
        json.customer customer.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.customer customer.to_jbuilder
      end
    end
    render json: builder.target!
  end

  def api15
    customer = Customer.find_by(id: params[:id]).first
    render_failed(4, 'いません') and return if customer.blank?
    customer.attributes = {
        name: params[:name],
        email: params[:email],
        password: params[:password],
        tel: params[:tel],
        sns_line: params[:sns_line],
        sns_zalo: params[:sns_zalo],
        sns_wechat: params[:sns_wechat]
    }
    if customer.save
      builder = Jbuilder.new do |json|
        json.customer customer.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.customer customer.to_jbuilder
      end
    end
    render json: builder.target!
  end

  def api20
    builder = Jbuilder.new do |json|
      json.user_count User.count
      json.shop_count Shop.count
    end
    render json: builder.target!
  end

  def api21
    PageViewType::CastGuide.create
    users = User.where(can_guided: true)
    total = users.count
    if params[:sort] == 'new'
      users = users.sort_new(params[:order])
    elsif params[:sort] == 'support'
      users = users.sort_support(params[:order])
    elsif params[:sort] == 'favorite'
      users = users.sort_favorite(params[:order])
    end
    users = users.where(users:{deleted_at: nil})
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    users = users.page(page).per(limit) if users.present?
    now = Time.zone.now
    supports = {}
    favorites = {}
    if customer_signed_in?
      customer = Customer.find_by(id: current_customer.id)
      customer.supports.each do |support|
        supports[support.receiver_id] = support
      end
      customer.favorites.each do |favorite|
        favorites[favorite.receiver_id] = favorite
      end
    end

    builders = Jbuilder.new do |json|
      json.users User.to_jbuilders(users)
      json.supports supports
      json.favorites favorites
      json.total total
    end
    render json: builders.target!

  end

  def api22
    user = User.find_by(id: params[:id])
    users = User.where( shop_id: user.shop_id,deleted_at: nil).where.not(id: user.id) if user.shop_id.present?
    total = users ? users.count : 0
    # if params[:sort] == 'new'
    #   users = users.sort_new(params[:order])
    # elsif params[:sort] == 'support'
    #   users = users.sort_support(params[:order])
    # elsif params[:sort] == 'favorite'
    #   users = users.sort_favorite(params[:order])
    # end
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 1
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    users = users.page(page).per(limit) if users.present?

    builders = Jbuilder.new do |json|
      json.users users ? User.to_jbuilders(users) : nil
      json.total total
    end
    render json: builders.target!

  end

  def api23
    shop = Shop.find_by(id: params[:id])
    reviews = shop.reviews.where(reviews:{is_displayed: true}).order("created_at desc") if shop
    total = reviews.count if reviews
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 1
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    reviews = reviews.page(page).per(limit) if reviews.present?
    builders = Jbuilder.new do |json|
      json.code 1
      json.reviews reviews ? Review.to_jbuilders(reviews) : nil
      json.total total
    end
    render json: builders.target!
  end

  def api24
    if customer_signed_in?
      customer = current_customer
      customer.attributes = {
        name: params[:name],
        tel: params[:tel],
        sns_line: params[:sns_line],
        sns_zalo: params[:sns_zalo],
        sns_wechat: params[:sns_wechat],
        birthday: params[:birthday]
      }
    end
    if customer.save!
      builder = Jbuilder.new do |json|
        json.customer customer.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.error "errorが発生しました。"
        json.code 0
      end
    end
    render json: builder.target!
  end

  def api25
    users = User.where(shop_id: params[:id],deleted_at: nil) if params[:id]
    new_users = users.find_new_user if users
    total = users.length
    if params[:sort] == 'new'
      users = users.sort_new(params[:order])
    elsif params[:sort] == 'support'
      users = users.sort_support(params[:order])
    elsif params[:sort] == 'favorite'
      users = users.sort_favorite(params[:order])
    end
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 1
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    users = users.page(page).per(limit) if users.present?

    builders = Jbuilder.new do |json|
      json.code 1
      json.users users ? User.to_jbuilders_for_user_list(users) : nil
      json.new_users new_users ? User.to_jbuilders_for_user_list(new_users) : nil
      json.total total
    end
    render json: builders.target!
  end

  def api26
    review = Review.find_by(id: params[:id]) if params[:id]
    builder = Jbuilder.new do |json|
      json.code 1
      json.review review.to_jbuilder
    end
    render json: builder.target!
  end

  def api27
    users = User.where(shop_id: params[:id],deleted_at: nil) if params[:id]
    builders = Jbuilder.new do |json|
      json.code 1
      json.users users ? User.to_jbuilders(users) : nil
    end
    render json: builders.target!
  end

  def api28
    user = User.find_by(id: params[:id])
    reviews = user.reviews.where(reviews:{is_displayed: true}).order("created_at desc") if user
    total = reviews.count if reviews
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 1
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    reviews = reviews.page(page).per(limit) if reviews.present?
    builders = Jbuilder.new do |json|
      json.code 1
      json.reviews reviews ? Review.to_jbuilders(reviews) : nil
      json.total total
    end
    render json: builders.target!
  end

  def api29
    customer = Customer.find_by(id: params[:id])
    review_shops = customer.review_shops.order("created_at desc") if customer
    review_users = customer.review_users.order("created_at desc") if customer

    review_shop_total = review_shops.count if review_shops
    review_user_total = review_users.count if review_users

    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 1
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    review_shops = review_shops.page(page).per(limit) if review_shops.present?
    review_users = review_users.page(page).per(limit) if review_users.present?

    builders = Jbuilder.new do |json|
      json.code 1
      json.review_shops review_shops ? Review.to_jbuilders(review_shops) : nil
      json.review_users review_users ? Review.to_jbuilders(review_users) : nil
      json.review_shop_total review_shop_total
      json.review_user_total review_user_total
    end
    render json: builders.target!
  end

  def api30
    shop = Shop.find_by(id: params[:id])
    render_failed(4, t('shop.error.not_find')) and return if shop.blank?
    users = shop.users.where(deleted_at: nil)
    ids = params[:cast_ids].split(',') if params[:cast_ids]
    users = users.where.not(id: ids) if users && ids
    builders = Jbuilder.new do |json|
      json.code 1
      json.users users ? User.to_jbuilders(users) : nil
    end
    render json: builders.target!
  end

  def api31
    shop = Shop.find_by(id: params[:id])
    render_failed(4, t('shop.error.not_find')) and return if shop.blank?
    users = shop.users.where(deleted_at: nil)
    users = users.where.not(id: params[:cast_id]) if users
    builders = Jbuilder.new do |json|
      json.code 1
      json.users users ? User.to_jbuilders(users) : nil
    end
    render json: builder.target!
  end

  def api32
    if customer_signed_in?
      builders = Jbuilder.new do |json|
        json.code 1
        json.customer current_customer.to_jbuilder
      end
    end
    render json: builders.target!
  end

  def api33
    if customer_signed_in?
      post = current_customer.favorites.where(sender_id:params[:sender_id],receiver_id: params[:receiver_id],receiver_type: 'User' ).first if params[:delete_type] == 'user'
      post = current_customer.favorites.where(sender_id:params[:sender_id],receiver_id: params[:receiver_id],receiver_type: 'Shop' ).first if params[:delete_type] == 'shop'
      post.delete
      builders = Jbuilder.new do |json|
        json.code 1
        json.customer current_customer.to_jbuilder
      end
    end
    render json: builders.target!
  end

  def api34
    lat = Range.new(*[params["east"], params["west"]].sort)
    lon = Range.new(*[params["north"], params["south"]].sort)
    shops = Shop.where(lat: lat, lon: lon).where(deleted_at: nil)
    total = shops.count
    builders = Jbuilder.new do |json|
      json.shops Shop.to_jbuilders(shops)
      json.total total
    end
    render json: builders.target!
  end

  def api35
    event = Event.find_by(id: params[:id])
    render_failed(4, t('shop.error.not_find')) and return if event.blank?
    builder = Jbuilder.new do |json|
      json.code 1
      json.event event.to_jbuilder
      json.events event.subject.shop_events
    end
    render json: builder.target!
  end

end

