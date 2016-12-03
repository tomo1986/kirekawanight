class Api::FrontController < ApiController

  def logout
    sign_out(current_customer) if customer_signed_in?
    builder = Jbuilder.new do |json|
      json.code 1
      json.custommer nil
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
        json.code 1
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


  def api0
    email = params[:email]
    password = params[:password]
    render_failed(4, t('admin.error.not_find')) and return if email.blank? || password.blank?
    customer = Customer.where(:email => params[:email]).first
    render_failed(4, t('admin.error.not_find')) and return  unless customer && customer.valid_password?(params[:password])
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
    users = User.where(job_type: params[:job_type])
    total = users.count
    if params[:sort] == 'new'
      users = users.sort_new(params[:order])
    elsif params[:sort] == 'support'
      users = users.sort_support(params[:order])
    elsif params[:sort] == 'favorite'
      users = users.sort_favorite(params[:order])

    end
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    users = users.page(page).per(limit) if users.present?
    now = Time.zone.now
    push_users = User.joins("join pickups on users.id = pickups.subject_id and pickups.type = 'PickupType::Push' and pickups.subject_type = 'User'").where("users.job_type = ? and (pickups.start_at <= ? and pickups.end_at > ?)",params[:job_type], now,now).order("pickups.number_place asc")
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
      json.push_users User.to_jbuilders(push_users)
      json.users User.to_jbuilders(users)
      json.supports supports
      json.favorites favorites
      json.total total
    end
    render json: builders.target!

  end
  def api3
    PageViewType::UserDetail.create(subject_type: 'User',subject_id: params[:id])
    user = User.find_by(id: params[:id])
    users = User.where( shop_id: user.shop_id)
    users = users.where.not(id: user.id)
    is_favorited = false
    is_favorited = current_customer.favorites.exists?(receiver_type: 'User', receiver_id: params[:id]) if customer_signed_in?

    builder = Jbuilder.new do |json|
      json.user user.to_jbuilder
      json.profile user.ja_profile ?  user.ja_profile.to_jbuilder : nil
      json.users user.shop ? User.to_jbuilders(users) : nil
      json.is_favorited is_favorited
    end
    render json: builder.target!

  end
  def api4
    PageViewType::ShopDetail.create(subject_type: 'Shop',subject_id: params[:id])
    shop = Shop.find_by(id: params[:id])
    render_failed(4, t('shop.error.not_find')) and return if shop.blank?
    users = shop.users
    reviews = shop.reviews.where(is_displayed: true) if shop.reviews
    is_favorited = false
    is_favorited = current_customer.favorites.exists?(receiver_type: 'Shop', receiver_id: params[:id]) if customer_signed_in?
    favorites = {}
    if customer_signed_in?
      current_customer.favorites.each do |favorite|
        favorites[favorite.receiver_id] = favorite
      end
    end
    shops = Shop.where(group_id: shop.group_id).where.not(id: shop.id)
    builder = Jbuilder.new do |json|
      json.code 1
      json.shop shop.to_jbuilder
      json.is_favorited is_favorited
      json.reviews reviews ? Review.to_jbuilders(reviews) : nil
      json.new_users users ? User.to_jbuilders(users.find_new_user) : nil
      json.users users ? User.to_jbuilders(users) : nil
      json.favorites favorites
      json.discounts Discount.to_jbuilders(shop.open_discounts)
      json.shops Shop.to_jbuilders(shops)

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
        message = '応援することで女の子が喜びます。'
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
    elsif params[:type] == 'bar'
      contact = ContactType::Bar.new
    elsif params[:type] == 'massage'
      contact = ContactType::Massage.new
    elsif params[:type] == 'sexy'
      contact = ContactType::Sexy.new
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
      builder = Jbuilder.new do |json|
        json.contact contact.to_jbuilder
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors contact.errors.full_messages
        json.status 0
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
      json.favorite_karaoke_users favorite_users ? User.to_jbuilders(favorite_users.where(job_type: 'karaoke')) : nil
      json.favorite_bar_users favorite_users ? User.to_jbuilders(users.where(job_type: 'bar')) : nil
      json.favorite_massage_users favorite_users ? User.to_jbuilders(users.where(job_type: 'massage')) : nil
      json.favorite_sexy_users favorite_users ? User.to_jbuilders(users.where(job_type: 'sexy')) : nil
      json.favorites favorites
      json.new_karaoke_users User.to_jbuilders(users.where(job_type: 'karaoke',created_at: from...to).order("id desc").limit(5))
      json.new_bar_users User.to_jbuilders(users.where(job_type: 'bar',created_at: from...to).order("id desc").limit(5))
      json.new_massage_users User.to_jbuilders(users.where(job_type: 'massage',created_at: from...to).order("id desc").limit(5))
      json.new_sexy_users User.to_jbuilders(users.where(job_type: 'sexy',created_at: from...to).order("id desc").limit(5))
      json.time_services Discount.to_jbuilders(Discount.open_time_discounts)
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
    shops = Shop.where(job_type: params[:job_type])
    total = shops.count

    if params[:sort] == 'new'
      shops = shops.sort_new(params[:order])
    elsif params[:sort] == 'support'
      shops = shops.sort_support(params[:order])
    elsif params[:sort] == 'favorite'
      shops = shops.sort_favorite(params[:order])
    end
      shops = shops.page(page).per(limit) if shops.present?

    favorites = {}
    if customer_signed_in?
      customer = Customer.find_by(id: current_customer.id)
      customer.favorites.each do |favorite|
        favorites[favorite.receiver_id] = favorite
      end
    end

    builders = Jbuilder.new do |json|
      json.shops Shop.to_jbuilders(shops)
      json.favorites favorites
      json.total total
    end
    render json: builders.target!

  end


  def api13
    if params[:type] == 'shop'
      review = ReviewType::Shop.new
    elsif params[:type] == 'user'
      review = ReviewType::User.new
    end

    review.attributes = {
        sender_type: params[:sender_type],
        sender_id: params[:sender_id],
        receiver_type: params[:receiver_type],
        receiver_id: params[:receiver_id],
        service_score: params[:service_score].to_i * 4,
        serving_score: params[:serving_score].to_i * 4,
        girl_score: params[:girl_score].to_i * 4,
        ambience_score: params[:ambience_score].to_i * 4,
        again_score: params[:again_score].to_i * 4,
        comment: params[:comment],
        is_displayed: false
    }

    if review.save!
      builder = Jbuilder.new do |json|
        json.review review.to_jbuilder
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors review.errors.full_messages
        json.status 0
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
        json.status true
      end
    else
      builder = Jbuilder.new do |json|
        json.customer customer.to_jbuilder
        json.status false
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
        json.status true
      end
    else
      builder = Jbuilder.new do |json|
        json.customer customer.to_jbuilder
        json.status false
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
end

