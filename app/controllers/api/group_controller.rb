class Api::GroupController < ApiController


  def logout
    sign_out(current_group) if group_signed_in?
    builder = Jbuilder.new do |json|
      json.code 1
    end
    render json: builder.target!
  end

  #login
  def api1
    email = params[:email]
    password = params[:password]
    render_failed(4, t('group.error.not_find')) and return if email.blank? || password.blank?
    group = Group.where(:email => params[:email]).first
    render_failed(4, t('group.error.not_find')) and return unless group && group.valid_password?(params[:password])
    group.remember_me = params[:remember_me]
    sign_in group

    builder = Jbuilder.new do |json|
      json.code 1
      json.group group.name
    end
    render json: builder.target!
  end

  def api2
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    builder = Jbuilder.new do |json|
      json.group current_group.to_jbuilder
    end
    render json: builder.target!
  end

  # shop lists
  def api3
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    shops = current_group.shops.find_open
    total = shops.count
    shops = shops.page(page).per(limit) if shops.present?
    builder = Jbuilder.new do |json|
      json.code 1
      json.shops Shop.to_jbuilders(shops)
      json.total total
    end
    render json: builder.target!
  end

  #shop deleted
  def api4
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    shop = Shop.find_by(id: params[:id])
    render_failed(4, t('group.error.no_shop')) and return unless shop
    shop.deleted_at = Time.zone.now
    if shop.save
      builder = Jbuilder.new do |json|
        json.code 1
        json.shop shop.to_jbuilder
      end
    else
      builder = Jbuilder.new do |json|
        json.errors shop.errors.full_messages
      end
    end
    render json: builder.target!

  end

  #shop new
  def api5
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    shop = Shop.new
    builder = Jbuilder.new do |json|
      json.code 1
      json.shop shop.to_jbuilder
    end
    render json: builder.target!
  end
  # create shop
  def api6
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    shop = Shop.new
    shop.attributes = {
      group_id: current_group.id,
      name: params[:name],
      name_kana: params[:name_kana],
      job_type: params[:job_type],
      tel: params[:tel],
      email: params[:email],
      password: params[:password],
      sns_line: params[:sns_line],
      sns_zalo: params[:sns_zalo],
      sns_wechat: params[:sns_wechat],
      address: params[:address],
      lat: params[:lat],
      lon: params[:lon],
      interview_ja: params[:interview_ja],
      interview_vn: params[:interview_vn],
      interview_en: params[:interview_en],
      is_credit: params[:is_credit],
      is_japanese: params[:is_japanese],
      is_english: params[:is_english],
      is_chinese: params[:is_chinese],
      is_korean: params[:is_korean],
      girls_count: params[:girls_count],
      tip: params[:tip],
      is_smoked: params[:is_smoked],
      opened_at: params[:opened_at],
      closed_at: params[:closed_at],
      budget_yen: params[:budget_yen],
      budget_vnd: params[:budget_vnd],
      budget_usd: params[:budget_usd],
      images: params[:images]
    }
    if params[:tags].presetn?
      params[:tags].each do |key,val|
        shop.tag_list.add(val["text"])
      end
    end

    if shop.save
      builder = Jbuilder.new do |json|
        json.shop shop.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors shop.errors.full_messages
      end
    end
    render json: builder.target!
  end

  #Shop detail
  def api7
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    shop = Shop.find_by(id: params[:id])
    render_failed(4, t('group.error.no_shop')) and return unless shop
    builder = Jbuilder.new do |json|
      json.shop shop.to_jbuilder
    end
    render json: builder.target!

  end

  # update shop
  def api8
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    shop = Shop.find_by(id: params[:id])
    render_failed(4, t('group.error.no_shop')) and return unless shop
    shop.attributes = {
        group_id: current_group.id,
        name: params[:name],
        name_kana: params[:name_kana],
        job_type: params[:job_type],
        tel: params[:tel],
        email: params[:email],
        password: params[:password],
        sns_line: params[:sns_line],
        sns_zalo: params[:sns_zalo],
        sns_wechat: params[:sns_wechat],
        address: params[:address],
        lat: params[:lat],
        lon: params[:lon],
        interview_ja: params[:interview_ja],
        interview_vn: params[:interview_vn],
        interview_en: params[:interview_en],
        is_credit: params[:is_credit],
        is_japanese: params[:is_japanese],
        is_english: params[:is_english],
        is_chinese: params[:is_chinese],
        is_korean: params[:is_korean],
        girls_count: params[:girls_count],
        tip: params[:tip],
        is_smoked: params[:is_smoked],
        opened_at: params[:opened_at],
        closed_at: params[:closed_at],
        budget_yen: params[:budget_yen],
        budget_vnd: params[:budget_vnd],
        budget_usd: params[:budget_usd]

    }
    if params[:images].present?
      params[:images].values.each do |image|
        shop.images.where(id: image[:id]).first.update(image: image[:url]) and next if image.present? && image[:id].present? && image[:id] != 'null'
        shop.images << ImageType::Shop.new(image: image[:url]) if image[:url] != 'null'
      end
    end
    if params[:tags].present?
      params[:tags].each do |key,val|
        shop.tag_list.add(val["text"])
      end
    end

    if shop.save!
      builder = Jbuilder.new do |json|
        json.shop shop.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors shop.errors.full_messages
      end
    end
    render json: builder.target!
  end



  # Shop detail charts
  def api9
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    now = Time.zone.now
    shop_id = params[:id]
    dates = []

    basic_sql = "from (select ('#{now.beginning_of_month.strftime('%Y-%m-%d')}') + interval (id - 1) day date from page_views limit 30) d"
    select_sql = "select d.date "
    date_sql = select_sql + basic_sql
    con = ActiveRecord::Base.connection
    result = con.select_all(date_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('x')
    dates << make_result

    select_sql = "select (select count(1) from page_views where type = 'PageViewType::ShopDetail' and subject_type = 'Shop' and subject_id = #{shop_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    pvcount_sql = select_sql + basic_sql
    result = con.select_all(pvcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('pv_count')
    dates << make_result

    select_sql = "select (select count(1) from posts where type = 'PostType::Support' and receiver_type = 'Shop' and receiver_id = #{shop_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    suportcount_sql = select_sql + basic_sql
    result = con.select_all(suportcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('support_count')
    dates << make_result

    select_sql = "select (select count(1) from posts where type = 'PostType::Favorite' and receiver_type = 'Shop' and receiver_id = #{shop_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    favoritecount_sql = select_sql + basic_sql
    result = con.select_all(favoritecount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('favoritecount_count')
    dates << make_result

    select_sql = "select (select count(1) from contacts where type = 'ContactType::ShopDetail' and subject_type = 'Shop' and subject_id = #{shop_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    contacttcount_sql = select_sql + basic_sql
    result = con.select_all(contacttcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('contacttcount_count')
    dates << make_result

    select_sql = "select (select count(1) from reviews where type = 'ReviewType::Shop' and receiver_type = 'Shop' and receiver_id = #{shop_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    review_sql = select_sql + basic_sql
    result = con.select_all(review_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('review_count')
    dates << make_result

    result = con.select_all("select count(1) from page_views where type = 'PageViewType::ShopDetail' and subject_type = 'Shop' and subject_id = #{shop_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_pv_count = result.rows[0][0]

    result = con.select_all("select count(1) from posts where type = 'PostType::Support' and receiver_type = 'Shop' and receiver_id = #{shop_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_support_count = result.rows[0][0]

    result = con.select_all("select count(1) from posts where type = 'PostType::Favorite' and receiver_type = 'Shop' and receiver_id = #{shop_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_favorite_count = result.rows[0][0]

    result = con.select_all("select count(1) from contacts where type = 'ContactType::ShopDetail' and subject_type = 'Shop' and subject_id = #{shop_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_contact_count = result.rows[0][0]

    result = con.select_all("select count(1) from reviews where type = 'ReviewType::Shop' and receiver_type = 'Shop' and receiver_id = #{shop_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_review_count = result.rows[0][0]

    render json: {chart_date: dates, monthly_pv_count: monthly_pv_count, monthly_support_count: monthly_support_count, monthly_favorite_count: monthly_favorite_count, monthly_contact_count: monthly_contact_count, monthly_review_count: monthly_review_count}
  end

  # Shop contacts and reviews
  def api10
    shop = Shop.find_by(id: params[:id])
    builders = Jbuilder.new do |json|
      json.contacts shop.contacts ? Contact.to_jbuilders(shop.contacts.order('id desc')) : nil
      json.reviews Review.to_jbuilders(shop.reviews.order('id desc'))
    end
    render json: builders.target!
  end

  # user list
  def api11
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    users = User.where(shop_id: current_group.shops.ids)
    total = users.count if users
    users = users.page(page).per(limit) if users.present?
    builder = Jbuilder.new do |json|
      json.code 1
      json.users User.to_jbuilders(users)
      json.total total
    end
    render json: builder.target!
  end

  # new user
  def api12
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    user = User.new
    builder = Jbuilder.new do |json|
      json.code 1
      json.user user.to_jbuilder
    end
    render json: builder.target!
  end

  # craate user
  def api13
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    user = User.new
    user.attributes = {
        shop_id: params[:shop_id],
        job_type: params[:job_type],
        name: params[:name],
        nick_name: params[:nick_name],
        birthplace: params[:birthplace],
        residence: params[:residence],
        birthday: params[:birthday],
        constellation: params[:constellation],
        blood_type: params[:blood_type],
        sex: 1,
        height: params[:height],
        weight: params[:weight],
        bust: "♡",
        bust_size: "♡",
        waist: "♡",
        hip: "♡",
        is_japanese: params[:is_japanese],
        is_english: params[:is_english]
    }

    if params[:images].present?
      params[:images].values.each do |image|
        user.images.where(id: image[:id]).first.update(image: image[:url]) and next if image.present? && image[:id].present? && image[:id] != 'null'
        user.images << ImageType::User.new(image: image[:url]) if image[:url] != 'null'
      end
    end

    if user.save!
      builder = Jbuilder.new do |json|
        json.user user.to_jbuilder
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors user.errors.full_messages
      end
    end
    render json: builder.target!
  end

  # user detail
  def api14
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    user = User.find_by(id: params[:id])
    render_failed(4, t('group.error.no_user')) and return unless user

    builders = Jbuilder.new do |json|
      json.code 1
      json.user user.to_jbuilder
    end
    render json: builders.target!
  end


  def api15
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    user = User.find_by(id: params[:id])
    render_failed(4, t('group.error.no_user')) and return unless user

    user.attributes = {
        shop_id: params[:shop_id],
        job_type: params[:job_type],
        name: params[:name],
        nick_name: params[:nick_name],
        birthplace: params[:birthplace],
        residence: params[:residence],
        birthday: params[:birthday],
        constellation: params[:constellation],
        blood_type: params[:blood_type],
        sex: 1,
        height: params[:height],
        weight: params[:weight],
        bust: "♡",
        bust_size: "♡",
        waist: "♡",
        hip: "♡",
        is_japanese: params[:is_japanese],
        is_english: params[:is_english]
    }

    if params[:images].present?
      params[:images].values.each do |image|
        user.images.where(id: image[:id]).first.update(image: image[:url]) and next if image.present? && image[:id].present? && image[:id] != 'null'
        image = user.images.new
        image.image = image[:url] and image.save! if image[:url] != 'null'
      end
    end

    if user.save!
      builder = Jbuilder.new do |json|
        json.user user.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors user.errors.full_messages
      end
    end
    render json: builder.target!
  end

  #user deleted
  def api16
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    user = User.find_by(id: params[:id])
    render_failed(4, t('group.error.no_shop')) and return unless user
    user.deleted_at = Time.zone.now
    if user.save
      builder = Jbuilder.new do |json|
        json.code 1
        json.user user.to_jbuilder
      end
    else
      builder = Jbuilder.new do |json|
        json.errors user.errors.full_messages
      end
    end
    render json: builder.target!

  end
  #user chart
  def api17
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    now = Time.zone.now
    user_id = params[:id]
    dates = []

    basic_sql = "from (select ('#{now.beginning_of_month.strftime('%Y-%m-%d')}') + interval (id - 1) day date from page_views limit 30) d"
    select_sql = "select d.date "
    date_sql = select_sql + basic_sql
    con = ActiveRecord::Base.connection
    result = con.select_all(date_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('x')
    dates << make_result

    select_sql = "select (select count(1) from page_views where type = 'PageViewType::UserDetail' and subject_type = 'User' and subject_id = #{user_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    pvcount_sql = select_sql + basic_sql
    result = con.select_all(pvcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('pv_count')
    dates << make_result

    select_sql = "select (select count(1) from posts where type = 'PostType::Support' and receiver_type = 'User' and receiver_id = #{user_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    suportcount_sql = select_sql + basic_sql
    result = con.select_all(suportcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('support_count')
    dates << make_result

    select_sql = "select (select count(1) from posts where type = 'PostType::Favorite' and receiver_type = 'User' and receiver_id = #{user_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    favoritecount_sql = select_sql + basic_sql
    result = con.select_all(favoritecount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('favoritecount_count')
    dates << make_result

    select_sql = "select (select count(1) from contacts where type = 'ContactType::UserDetail' and subject_type = 'User' and subject_id = #{user_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    contacttcount_sql = select_sql + basic_sql
    result = con.select_all(contacttcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('contacttcount_count')
    dates << make_result

    select_sql = "select (select count(1) from reviews where type = 'ReviewType::User' and receiver_type = 'User' and receiver_id = #{user_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    review_sql = select_sql + basic_sql
    result = con.select_all(review_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('review_count')
    dates << make_result

    result = con.select_all("select count(1) from page_views where type = 'PageViewType::UserDetail' and subject_type = 'User' and subject_id = #{user_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_pv_count = result.rows[0][0]

    result = con.select_all("select count(1) from posts where type = 'PostType::Support' and receiver_type = 'User' and receiver_id = #{user_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_support_count = result.rows[0][0]

    result = con.select_all("select count(1) from posts where type = 'PostType::Favorite' and receiver_type = 'User' and receiver_id = #{user_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_favorite_count = result.rows[0][0]

    result = con.select_all("select count(1) from contacts where type = 'ContactType::UserDetail' and subject_type = 'User' and subject_id = #{user_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_contact_count = result.rows[0][0]

    result = con.select_all("select count(1) from reviews where type = 'ReviewType::User' and receiver_type = 'User' and receiver_id = #{user_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_review_count = result.rows[0][0]

    render json: {chart_date: dates, monthly_pv_count: monthly_pv_count, monthly_support_count: monthly_support_count, monthly_favorite_count: monthly_favorite_count, monthly_contact_count: monthly_contact_count, monthly_review_count: monthly_review_count}
  end

  def api18
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    user = User.find_by(id: params[:id])
    builders = Jbuilder.new do |json|
      json.contacts Contact.to_jbuilders(user.contacts.order('id desc'))
      json.reviews Review.to_jbuilders(user.reviews.order('id desc'))
    end
    render json: builders.target!
  end

  def api19
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    discounts = Discount.where(type: "DiscountType::Time",subject_type:"Shop", subject_id: current_group.shops.ids).order("id desc")
    builders = Jbuilder.new do |json|
      json.discounts Discount.to_jbuilders(discounts)
    end
    render json: builders.target!
  end

  def api20
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    discount = Discount.new
    builder = Jbuilder.new do |json|
      json.discount discount.to_jbuilder
    end
    render json: builder.target!
  end

  def api21
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    discount = DiscountType::Time.new(subject_type:"Shop",subject_id: params[:subject_id])
    discount.attributes = {
        groups: params[:groups],
        peoples: params[:peoples],
        price: params[:price],
        content: params[:content],
        watchword: params[:watchword],
        start_at: params[:start_at],
        end_at: params[:end_at],
        tel: params[:tel],
        is_displayed: params[:is_displayed]
    }
    discount.content = discount.make_content_ja
    if discount.save
      builder = Jbuilder.new do |json|
        json.discount discount.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors discount.errors.full_messages
      end
    end
    render json: builder.target!
  end

  def api22
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    discount = Discount.find_by(id: params[:id])
    render_failed(4, t('group.error.no_shop')) and return unless discount
    builder = Jbuilder.new do |json|
      json.discount discount.to_jbuilder
    end
    render json: builder.target!
  end

  def api23
    render_failed(4, t('group.error.no_login')) and return unless group_signed_in?
    discount = Discount.find_by(id: params[:id])
    render_failed(4, t('group.error.no_shop')) and return unless discount
    discount.attributes = {
        groups: params[:groups],
        peoples: params[:peoples],
        price: params[:price],
        content: params[:content],
        watchword: params[:watchword],
        start_at: params[:start_at],
        end_at: params[:end_at],
        tel: params[:tel],
        is_displayed: params[:is_displayed]
    }
    if discount.save
      builder = Jbuilder.new do |json|
        json.discount discount.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors discount.errors.full_messages
      end
    end
    render json: builder.target!
  end


  # def api46
  #   if params[:type] == 'time'
  #     discount = DiscountType::Time.new
  #   end
  #
  #   discount.attributes = {
  #       group_id: current_group.id,
  #       groups: params[:groups],
  #       peoples: params[:peoples],
  #       price: params[:price],
  #       content: params[:content],
  #       watchword: params[:watchword],
  #       start_at: params[:start_at],
  #       end_at: params[:end_at],
  #       tel: params[:tel],
  #       is_displayed: params[:is_displayed]
  #   }
  #   discount.content = discount.make_content_ja
  #   if discount.save
  #     builder = Jbuilder.new do |json|
  #       json.discount discount.to_jbuilder
  #       json.status 1
  #     end
  #   else
  #     builder = Jbuilder.new do |json|
  #       json.errors discount.errors.full_messages
  #       json.status 0
  #     end
  #   end
  #   render json: builder.target!
  # end

end
