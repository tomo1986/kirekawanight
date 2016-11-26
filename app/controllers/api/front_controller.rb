class Api::FrontController < ApiController

  def api0
    if session[:customer_id]
      customer = Customer.find(session[:customer_id])
    else
      customer = nil
    end
    builder = Jbuilder.new do |json|
      json.authenticity_token form_authenticity_token
      json.login_customer customer
    end
    render json: builder.target!
  end

  def api0_1
    if customer_signed_in?
      customer = Customer.find(session[:customer_id])
      sign_out customer
      session[:customer_id] = nil
    end
    render json: nil
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

    total = User.where(job_type: params[:job_type]).count
    users = User.where(job_type: params[:job_type])
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
    users = User.where( group_id: user.group_id)
    users = users.where.not(id: user.id)
    is_favorited = false
    is_favorited = current_customer.favorites.exists?(receiver_type: 'User', receiver_id: params[:id]) if customer_signed_in?

    builder = Jbuilder.new do |json|
      json.user user.to_jbuilder
      json.profile user.ja_profile ?  user.ja_profile.to_jbuilder : nil
      json.users user.group ? User.to_jbuilders(users) : nil
      json.is_favorited is_favorited
    end
    render json: builder.target!

  end
  def api4
    PageViewType::GroupDetail.create(subject_type: 'Group',subject_id: params[:id])
    group = Group.find_by(id: params[:id])
    users = User.where( group_id: params[:id])
    reviews = group.reviews.where(is_displayed: true) if group.reviews
    is_favorited = false
    is_favorited = current_customer.favorites.exists?(receiver_type: 'Group', receiver_id: params[:id]) if customer_signed_in?
    favorites = {}
    if customer_signed_in?
      current_customer.favorites.each do |favorite|
        favorites[favorite.receiver_id] = favorite
      end
    end

    builder = Jbuilder.new do |json|
      json.group group.to_jbuilder
      json.is_favorited is_favorited
      json.reviews reviews ? Review.to_jbuilders(reviews) : nil
      json.users users ? User.to_jbuilders(users) : nil
      json.favorites favorites
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
    elsif params[:receiver_type] == 'Group'
      group = Group.find_by(id: params[:receiver_id])
      support_count = group.supports.count
      favorite_count = group.favorites.count

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

  def api9
    email = params[:email]
    password = params[:password]
    render json: 'error' if email.blank? || password.blank?
    render json: 'error' if Customer.find_by(email: email)
    customer =Customer.create(name: params[:name], email: email, password: password)
    if customer.save!
      session[:customer_id] = customer.id
      sign_in customer
      builder = Jbuilder.new do |json|
        json.code 1
        json.customer customer
      end
    end
    render json: builder.target!

  end

  def api10
    email = params[:email]
    password = params[:password]
    p "============1==========="
    render json: 'email or password is missing.' and return if email.blank? || password.blank?
    p "============2==========="
    customer = Customer.where(:email => params[:email]).first
    p "============3==========="
    render json: 'email or password is missing.' and return unless customer && customer.valid_password?(params[:password])
    p "============4==========="
    session[:customer_id] = customer.id
    sign_in customer
    builder = Jbuilder.new do |json|
      json.code 1
      json.customer customer
    end
    render json: builder.target!
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
      json.new_karaoke_users User.to_jbuilders(users.where(job_type: 'karaoke',created_at: from...to).limit(5))
      json.new_bar_users User.to_jbuilders(users.where(job_type: 'bar',created_at: from...to).limit(5))
      json.new_massage_users User.to_jbuilders(users.where(job_type: 'massage',created_at: from...to).limit(5))
      json.new_sexy_users User.to_jbuilders(users.where(job_type: 'sexy',created_at: from...to).limit(5))

    end
    render json: builders.target!
  end
  #group list page
  def api12
    if params[:job_type] == 'karaoke'
      PageViewType::GroupKaraoke.create
    elsif params[:job_type] == 'bar'
      PageViewType::GroupBar.create
    elsif params[:job_type] == 'massage'
      PageViewType::GroupMassage.create
    elsif params[:job_type] == 'sexy'
      PageViewType::GroupSexy.create
    end

    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    total = Group.where(job_type: params[:job_type]).count
    groups = Group.where(job_type: params[:job_type])
    groups = groups.page(page).per(limit) if groups.present?

    favorites = {}
    if customer_signed_in?
      customer = Customer.find_by(id: current_customer.id)
      customer.favorites.each do |favorite|
        favorites[favorite.receiver_id] = favorite
      end
    end

    builders = Jbuilder.new do |json|
      json.groups Group.to_jbuilders(groups)
      json.favorites favorites
      json.total total
    end
    render json: builders.target!

  end


  def api13
    if params[:type] == 'group'
      review = ReviewType::Group.new
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
    render json: 'このメールアドレスはすでに登録されております。' and return if Customer.find_by(email: params[:email]).first
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
    render json: "いません" and return if customer.blank?
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
end

