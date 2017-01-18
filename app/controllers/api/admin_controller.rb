class Api::AdminController < ApiController

  def logout
    sign_out(current_admin) if admin_signed_in?
    builder = Jbuilder.new do |json|
      json.code 1
    end
    render json: builder.target!
  end

  def all_admins
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    admins = Admin.all
    render json: admins
  end

  def all_users
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    users = User.where(deleted_at: nil)
    builders = Jbuilder.new do |json|
      json.users User.to_jbuilders(users)
    end
    render json: builders.target!
  end

  def all_shops
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    shops = Shop.where(deleted_at: nil)
    builders = Jbuilder.new do |json|
      json.code 1
      json.shops Shop.to_jbuilders(shops)
    end
    render json: builders.target!

  end

  def all_groups
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    groups = Group.where(deleted_at: nil)
    builders = Jbuilder.new do |json|
      json.code 1
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

  def api1
    email = params[:email]
    password = params[:password]
    render_failed(4, t('admin.error.not_find')) and return if email.blank? || password.blank?
    admin = Admin.where(:email => params[:email]).first
    render_failed(4, t('admin.error.not_find')) and return  unless admin && admin.valid_password?(params[:password])
    admin.remember_me = params[:remember_me]
    sign_in admin
    builder = Jbuilder.new do |json|
      json.code 1
      json.admin admin
    end
    render json: builder.target!
  end



  def api2
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    groups = Group.where(deleted_at: nil)
    total = groups.count
    groups = groups.page(page).per(limit) if groups.present?
    builders = Jbuilder.new do |json|
      json.groups Group.to_jbuilders(groups)
      json.total total
    end
    render json: builders.target!
  end

  def api3
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    group = Group.new
    builder = Jbuilder.new do |json|
      json.group group.to_jbuilder
    end
    render json: builder.target!
  end

  def api4
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    group = Group.new
    group.attributes = {
      name: params[:name],
      name_kana: params[:name_kana],
      tel: params[:tel],
      email: params[:email],
      password: params[:password],
      address: params[:address],
      lat: params[:lat],
      lon: params[:lon]
    }

    if group.save
      builder = Jbuilder.new do |json|
        json.group group.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors group.errors.full_messages
      end
    end
    render json: builder.target!
  end

  def api5
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    group = Group.find_by(id: params[:id])
    builder = Jbuilder.new do |json|
      json.group group.to_jbuilder
    end
    render json: builder.target!

  end
  def api6
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    group = Group.find_by(id: params[:id])
    group.attributes = {
        name: params[:name],
        name_kana: params[:name_kana],
        tel: params[:tel],
        email: params[:email],
        password: params[:password],
        address: params[:address],
        lat: params[:lat],
        lon: params[:lon]
    }
    if params[:images].present?
      params[:images].values.each do |image|
        group.images.where(id: image[:id]).first.update(image: image[:url]) and next if image.present? && image[:id].present? && image[:id] != 'null'
        group.images << ImageType::Group.new(image: image[:url]) if image[:url] != 'null'
      end
    end

    if group.save!
      builder = Jbuilder.new do |json|
        json.group group.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors group.errors.full_messages
      end
    end
    render json: builder.target!
  end

  def api7
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    group = Group.find_by(id: params[:id])
    render_failed(4, t('admin.error.no_shop')) and return unless group
    group.deleted_at = Time.zone.now
    if group.save
      builder = Jbuilder.new do |json|
        json.code 1
        json.group group.to_jbuilder
      end
    else
      builder = Jbuilder.new do |json|
        json.errors group.errors.full_messages
      end
    end
    render json: builder.target!

  end

  def api8
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    users = User.keyword_filter(params[:keyword],params[:group_id],params[:shop_id],params[:job_type])
    total = users.count
    users = users.page(page).per(limit) if users.present?
    builders = Jbuilder.new do |json|
      json.users User.to_jbuilders_for_admin(users)
      json.total total
    end
    render json: builders.target!
  end

  def api9
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    user = User.find_by(id: params[:id])
    render_failed(4, t('admin.error.no_user')) and return unless user
    builders = Jbuilder.new do |json|
      json.code 1
      json.user user.to_jbuilder_for_admin
    end
    render json: builders.target!
  end

  def api10
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    user = User.new
    builder = Jbuilder.new do |json|
      json.code 1
      json.user user.to_jbuilder_for_admin
    end
    render json: builder.target!
  end

  def api11
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    user = User.new
    if params[:ja]
      user.user_profiles << ProfileType::Ja.create(
          like_boy: params[:ja]['like_boy'],
          like_girl: params[:ja]['like_girl'],
          my_color: params[:ja]['my_color'],
          happy_word: params[:ja]['happy_word'],
          gesture: params[:ja]['gesture'],
          attracted: params[:ja]['attracted'],
          love_situation: params[:ja]['love_situation'],
          first_love: params[:ja]['first_love'],
          how_to_approach: params[:ja]['how_to_approach'],
          how_to_holiday: params[:ja]['how_to_holiday'],
          idea_couple: params[:ja]['idea_couple'],
          take_one: params[:ja]['take_one'],
          like_word: params[:ja]['like_word'],
          like_music: params[:ja]['like_music'],
          like_place: params[:ja]['like_place'],
          like_food: params[:ja]['like_food'],
          like_drink: params[:ja]['like_drink'],
          like_sports: params[:ja]['like_sports'],
          best_feature: params[:ja]['best_feature'],
          love_tips: params[:ja]['love_tips'],
          character: params[:ja]['character'],
          hobby: params[:ja]['hobby'],
          skill: params[:ja]['skill'],
          habit: params[:ja]['habit'],
          brag: params[:ja]['brag'],
          my_fad: params[:ja]['my_fad'],
          secret_talk: params[:ja]['secret_talk'],
          dream: params[:ja]['dream'],
          go: params[:ja]['go'],
          want: params[:ja]['want'],
          do_something: params[:ja]['do_something'],
          happy_event: params[:ja]['happy_event'],
          painful_event: params[:ja]['painful_event'],
          previous_life: params[:ja]['previous_life'],
          admire_person: params[:ja]['admire_person'],
          interview: params[:ja]['interview']
      )
    end

    user.attributes = {
        name: params[:name],
        shop_id: params[:shop_id],
        nick_name: params[:nick_name],
        birthplace: params[:birthplace],
        residence: params[:residence],
        birthday: params[:birthday],
        constellation: params[:constellation],
        job_type: params[:job_type],
        blood_type: params[:blood_type],
        sex: params[:sex],
        sns_line: params[:sns_line],
        sns_zalo: params[:sns_zalo],
        sns_wechat: params[:sns_wechat],
        height: params[:height],
        weight: params[:weight],
        bust: params[:bust],
        bust_size: params[:bust_size],
        waist: params[:waist],
        hip: params[:hip],
        is_japanese: params[:is_japanese],
        is_english: params[:is_english],
        is_chinese: params[:is_chinese],
        is_korean: params[:is_korean],

        can_guided: params[:can_guided],
        japanese_level: params[:japanese_level],
        images: params[:images],
        face_images: params[:face_images]
    }
    if params[:tags]
      params[:tags].each do |key,val|
        user.tag_list.add(val["name"])
      end
    end

    if user.save!
      if params[:is_blog].to_i == 1
        blog = BlogType::Introduction.new
        blog.auto_save_user(user)
      end
      builder = Jbuilder.new do |json|
        json.user user.to_jbuilder_for_admin
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors user.errors.full_messages
      end
    end
    render json: builder.target!
  end

  def api12
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    user = User.find_by(id: params[:id])
    render_failed(4, t('admin.error.no_user')) and return unless user
    if params[:ja]
      user.user_profiles << ProfileType::Ja.new if user.ja_profile.nil?
      user.ja_profile.attributes = {
          like_boy: params[:ja]['like_boy'],
          like_girl: params[:ja]['like_girl'],
          my_color: params[:ja]['my_color'],
          happy_word: params[:ja]['happy_word'],
          gesture: params[:ja]['gesture'],
          attracted: params[:ja]['attracted'],
          love_situation: params[:ja]['love_situation'],
          first_love: params[:ja]['first_love'],
          how_to_approach: params[:ja]['how_to_approach'],
          how_to_holiday: params[:ja]['how_to_holiday'],
          idea_couple: params[:ja]['idea_couple'],
          take_one: params[:ja]['take_one'],
          like_word: params[:ja]['like_word'],
          like_music: params[:ja]['like_music'],
          like_place: params[:ja]['like_place'],
          like_food: params[:ja]['like_food'],
          like_drink: params[:ja]['like_drink'],
          like_sports: params[:ja]['like_sports'],
          best_feature: params[:ja]['best_feature'],
          love_tips: params[:ja]['love_tips'],
          character: params[:ja]['character'],
          hobby: params[:ja]['hobby'],
          skill: params[:ja]['skill'],
          habit: params[:ja]['habit'],
          brag: params[:ja]['brag'],
          my_fad: params[:ja]['my_fad'],
          secret_talk: params[:ja]['secret_talk'],
          dream: params[:ja]['dream'],
          go: params[:ja]['go'],
          want: params[:ja]['want'],
          do_something: params[:ja]['do_something'],
          happy_event: params[:ja]['happy_event'],
          painful_event: params[:ja]['painful_event'],
          previous_life: params[:ja]['previous_life'],
          admire_person: params[:ja]['admire_person'],
          interview: params[:ja]['interview']
      }
    end

    user.attributes = {
        name: params[:name],
        shop_id: params[:shop_id],
        nick_name: params[:nick_name],
        birthplace: params[:birthplace],
        residence: params[:residence],
        birthday: params[:birthday],
        constellation: params[:constellation],
        job_type: params[:job_type],
        blood_type: params[:blood_type],
        sex: params[:sex],
        sns_line: params[:sns_line],
        sns_zalo: params[:sns_zalo],
        sns_wechat: params[:sns_wechat],
        height: params[:height],
        weight: params[:weight],
        bust: params[:bust],
        bust_size: params[:bust_size],
        waist: params[:waist],
        hip: params[:hip],
        is_japanese: params[:is_japanese],
        is_english: params[:is_english],
        is_chinese: params[:is_chinese],
        is_korean: params[:is_korean],
        can_guided: params[:can_guided],
        japanese_level: params[:japanese_level]
    }


    if params[:images].present?
      params[:images].values.each do |image|
        user.images.where(id: image[:id]).first.update(image: image[:url]) and next if image.present? && image[:id].present? && image[:id] != 'null'
        image = user.images.new
        image.image = image[:url] and image.save! if image[:url] != 'null'
      end
    end
    if params[:face_images].present?
      params[:face_images].values.each do |image|
        user.face_images.where(id: image[:id]).first.update(image: image[:url]) and next if image.present? && image[:id].present? && image[:id] != 'null'
        image = user.face_images.new
        image.image = image[:url] and image.save! if image[:url] != 'null'
      end
    end
    if params[:tags]
      params[:tags].each do |key,val|
        user.tag_list.add(val["name"])
      end
    end

    if user.save!
      if params[:is_blog].to_i == 1
        blog = BlogType::Introduction.new
        blog.auto_save_user(user)
      end
      builder = Jbuilder.new do |json|
        json.user user.to_jbuilder_for_admin
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors user.errors.full_messages
      end
    end
    render json: builder.target!
  end

  def api13
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    user = User.find_by(id: params[:id])
    render_failed(4, t('admin.error.no_user')) and return unless user
    user.deleted_at = user && user.deleted_at ? nil : Time.zone.now
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

  def api14
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    total = Contact.count
    contacts = Contact.all
    contacts = contacts.order("id desc").page(page).per(limit) if contacts.present?
    builders = Jbuilder.new do |json|
      json.contacts Contact.to_jbuilders(contacts)
      json.total total
    end
    render json: builders.target!
  end

  def api15
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    contact = Contact.new
    builders = Jbuilder.new do |json|
      json.contact contact.to_jbuilder
    end
    render json: builders.target!

  end

  def api16
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    contact = Contact.new
    contact.attributes = {
        type:params[:type],
        subject_type:params[:subject_type],
        subject_id:params[:subject_id],
        name:params[:name],
        tel:params[:tel],
        email:params[:email],
        sns_line:params[:sns_line],
        sns_zalo:params[:sns_zalo],
        sns_wechat:params[:sns_wechat],
        message:params[:message]
    }
    if contact.save
      builder = Jbuilder.new do |json|
        json.code 1
        json.contact contact.to_jbuilder
      end
    else
      builder = Jbuilder.new do |json|
        json.errors contact.errors.full_messages
      end
    end
    render json: builder.target!
  end

  def api17
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    contact = Contact.find_by(id: params[:id])
    render_failed(4, t('admin.error.no_user')) and return unless contact
    builder = Jbuilder.new do |json|
      json.contact contact.to_jbuilder
    end
    render json: builder.target!
  end

  def api18
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    contact = Contact.find_by(id: params[:id])
    render_failed(4, t('admin.error.no_user')) and return unless contact
    contact.attributes = {
        type:params[:type],
        subject_type:params[:subject_type],
        subject_id:params[:subject_id],
        name:params[:name],
        tel:params[:tel],
        email:params[:email],
        sns_line:params[:sns_line],
        sns_zalo:params[:sns_zalo],
        sns_wechat:params[:sns_wechat],
        message:params[:message]
    }
    if contact.save
      builder = Jbuilder.new do |json|
        json.code 1
        json.contact contact.to_jbuilder
      end
    else
      builder = Jbuilder.new do |json|
        json.errors contact.errors.full_messages
      end
    end
    render json: builder.target!
  end

  def api19
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    total = Pickup.count
    pickups = Pickup.all
    pickups = pickups.page(page).per(limit) if pickups.present?
    builders = Jbuilder.new do |json|
      json.pickups Pickup.to_jbuilders(pickups)
      json.total total
    end
    render json: builders.target!
  end

  def api20
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    pickup = Pickup.new
    builders = Jbuilder.new do |json|
      json.pickup pickup.to_jbuilder
    end
    render json: builders.target!
  end


  def api21
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    if params[:type] == 'top'
      pickup = PickupType::Top.new
    elsif params[:type] == 'push'
      pickup = PickupType::Push.new
    end

    pickup.attributes = {
        subject_type: params[:subject_type],
        subject_id: params[:subject_id],
        price: params[:price],
        start_at: params[:start_at],
        end_at: params[:end_at],
        number_place: params[:number_place]
    }
    if pickup.save!
      builder = Jbuilder.new do |json|
        json.pickup pickup.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors pickup.errors.full_messages
        json.code 0
      end
    end
    render json: builder.target!
  end

  def api22
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    pickup = Pickup.find_by(id: params[:id])
    render_failed(4, t('admin.error.no_login')) and return unless pickup
    
    builder = Jbuilder.new do |json|
      json.pickup pickup.to_jbuilder
      json.code 1
    end
    render json: builder.target!
  end

  def api23
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    pickup = Pickup.find_by(id: params[:id])
    render_failed(4, t('admin.error.no_login')) and return unless pickup

    pickup.attributes = {
        subject_type: params[:subject_type],
        subject_id: params[:subject_id],
        price: params[:price],
        start_at: params[:start_at],
        end_at: params[:end_at],
        number_place: params[:number_place]
    }
    if params[:type] == 'top'
      pickup.type = 'PickupType::Top'
    elsif params[:type] == 'push'
      pickup.type = 'PickupType::Push'
    end

    if pickup.save!
      builder = Jbuilder.new do |json|
        json.pickup pickup.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors pickup.errors.full_messages
        json.code 0
      end
    end
    render json: builder.target!

  end
  def api25
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    total = Banner.count
    banners = Banner.all
    banners = banners.page(page).per(limit) if banners.present?
    builders = Jbuilder.new do |json|
      json.banners Banner.to_jbuilders(banners)
      json.total total
    end
    render json: builders.target!
  end
  def api26
    banner = Banner.find_by(id: params[:id])
    builder = Jbuilder.new do |json|
      json.banner banner.to_jbuilder
    end
    render json: builder.target!
  end
  def api27
    banner = Banner.new
    builder = Jbuilder.new do |json|
      json.banner banner.to_jbuilder
    end
    render json: builder.target!
  end
  def api28
    banner = Banner.new
    banner.attributes = {
        type: params[:type],
        subject_type: params[:subject_type],
        subject_id: params[:subject_id],
        title: params[:title],
        link: params[:link],
        is_target_blank: params[:is_target_blank],
        article: params[:article],
        start_at: params[:start_at],
        end_at: params[:end_at],
        image: params[:image]
    }
    if banner.save!
      builder = Jbuilder.new do |json|
        json.banner banner.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors banner.errors.full_messages
        json.code 0
      end
    end
    render json: builder.target!

  end
  def api29
    banner = Banner.find_by(id: params[:id])
    banner.attributes = {
        type: params[:type],
        subject_type: params[:subject_type],
        subject_id: params[:subject_id],
        title: params[:title],
        link: params[:link],
        is_target_blank: params[:is_target_blank],
        article: params[:article],
        start_at: params[:start_at],
        end_at: params[:end_at]
    }
    if banner.save!
      builder = Jbuilder.new do |json|
        json.banner banner.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors banner.errors.full_messages
        json.code 0
      end
    end
    render json: builder.target!
  end

  def api30
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    total = Blog.count
    blogs = Blog.all
    blogs = blogs.page(page).per(limit) if blogs.present?
    builders = Jbuilder.new do |json|
      json.blogs Blog.to_jbuilders(blogs)
      json.total total
    end
    render json: builders.target!
  end

  def api31
    blog = Blog.find_by(id: params[:id])
    builder = Jbuilder.new do |json|
      json.blog blog.to_jbuilder
    end
    render json: builder.target!
  end
  def api32
    blog = Blog.new
    builder = Jbuilder.new do |json|
      json.blog blog.to_jbuilder
    end
    render json: builder.target!
  end
  def api33
    if params[:type] == 'Shop'
      blog = BlogType::Shop.new
    elsif  params[:type] == 'User'
      blog = BlogType::User.new
    elsif params[:type] == 'Play'
      blog = BlogType::Play.new
    end
    blog.attributes = {
        subject_type: params[:subject_type],
        subject_id: params[:subject_id],
        head_title_ja: params[:head_title_ja],
        head_title_vn: params[:head_title_vn],
        head_title_en: params[:head_title_en],
        head_keyword_ja: params[:head_keyword_ja],
        head_keyword_vn: params[:head_keyword_vn],
        head_keyword_en: params[:head_keyword_en],
        head_description_ja: params[:head_description_ja],
        head_description_vn: params[:head_description_vn],
        head_description_en: params[:head_description_en],
        title_ja: params[:title_ja],
        title_vn: params[:title_vn],
        title_en: params[:title_en],
        article_ja: params[:article_ja],
        article_vn: params[:article_vn],
        article_en: params[:article_en]
    }
    if blog.save!
      builder = Jbuilder.new do |json|
        json.blog blog.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors blog.errors.full_messages
        json.code 0
      end
    end
    render json: builder.target!

  end
  def api34
    blog = Blog.find_by(id: params[:id])
    blog.attributes = {
        subject_type: params[:subject_type],
        subject_id: params[:subject_id],
        head_title_ja: params[:head_title_ja],
        head_title_vn: params[:head_title_vn],
        head_title_en: params[:head_title_en],
        head_keyword_ja: params[:head_keyword_ja],
        head_keyword_vn: params[:head_keyword_vn],
        head_keyword_en: params[:head_keyword_en],
        head_description_ja: params[:head_description_ja],
        head_description_vn: params[:head_description_vn],
        head_description_en: params[:head_description_en],
        title_ja: params[:title_ja],
        title_vn: params[:title_vn],
        title_en: params[:title_en],
        article_ja: params[:article_ja],
        article_vn: params[:article_vn],
        article_en: params[:article_en]
    }
    if blog.save!
      builder = Jbuilder.new do |json|
        json.blog blog.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors blog.errors.full_messages
        json.code 0
      end
    end
    render json: builder.target!
  end






  def api40
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

  def api41
    now = Time.zone.now
    group_id = params[:id]
    dates = []

    basic_sql = "from (select ('#{now.beginning_of_month.strftime('%Y-%m-%d')}') + interval (id - 1) day date from page_views limit 30) d"
    select_sql = "select d.date "
    date_sql = select_sql + basic_sql
    con = ActiveRecord::Base.connection
    result = con.select_all(date_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('x')
    dates << make_result

    select_sql = "select (select count(1) from page_views where type = 'PageViewType::ShopDetail' and subject_type = 'Shop' and subject_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    pvcount_sql = select_sql + basic_sql
    result = con.select_all(pvcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('pv_count')
    dates << make_result

    select_sql = "select (select count(1) from posts where type = 'PostType::Support' and receiver_type = 'Shop' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    suportcount_sql = select_sql + basic_sql
    result = con.select_all(suportcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('support_count')
    dates << make_result

    select_sql = "select (select count(1) from posts where type = 'PostType::Favorite' and receiver_type = 'Shop' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    favoritecount_sql = select_sql + basic_sql
    result = con.select_all(favoritecount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('favoritecount_count')
    dates << make_result

    select_sql = "select (select count(1) from contacts where type = 'ContactType::ShopDetail' and subject_type = 'Shop' and subject_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    contacttcount_sql = select_sql + basic_sql
    result = con.select_all(contacttcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('contacttcount_count')
    dates << make_result

    select_sql = "select (select count(1) from reviews where type = 'ReviewType::Shop' and receiver_type = 'Shop' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    review_sql = select_sql + basic_sql
    result = con.select_all(review_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('review_count')
    dates << make_result

    result = con.select_all("select count(1) from page_views where type = 'PageViewType::ShopDetail' and subject_type = 'Shop' and subject_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_pv_count = result.rows[0][0]

    result = con.select_all("select count(1) from posts where type = 'PostType::Support' and receiver_type = 'Shop' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_support_count = result.rows[0][0]

    result = con.select_all("select count(1) from posts where type = 'PostType::Favorite' and receiver_type = 'Shop' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_favorite_count = result.rows[0][0]

    result = con.select_all("select count(1) from contacts where type = 'ContactType::ShopDetail' and subject_type = 'Shop' and subject_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_contact_count = result.rows[0][0]

    result = con.select_all("select count(1) from reviews where type = 'ReviewType::Shop' and receiver_type = 'Shop' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_review_count = result.rows[0][0]

    render json: {chart_date: dates, monthly_pv_count: monthly_pv_count, monthly_support_count: monthly_support_count, monthly_favorite_count: monthly_favorite_count, monthly_contact_count: monthly_contact_count, monthly_review_count: monthly_review_count}
  end





  def api42
    user = User.find_by(id: params[:id])
    builders = Jbuilder.new do |json|
      json.contacts Contact.to_jbuilders(user.contacts.order('id desc'))
      json.reviews Review.to_jbuilders(user.reviews.order('id desc'))
    end
    render json: builders.target!
  end

  def api43
    shop = Shop.find_by(id: params[:id])
    builders = Jbuilder.new do |json|
      json.contacts shop.contacts ? Contact.to_jbuilders(shop.contacts.order('id desc')) : nil
      json.reviews Review.to_jbuilders(shop.reviews.order('id desc'))
    end
    render json: builders.target!
  end

  def api44
    tags = Tag.all
    builders = Jbuilder.new do |json|
      json.tags Tag.to_jbuilders(tags)
    end
    render json: builders.target!
  end






  def api50
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    shops = Shop.all
    total = shops.count
    shops = shops.page(page).per(limit) if shops.present?
    builders = Jbuilder.new do |json|
      json.shops Shop.to_jbuilders(shops)
      json.total total
    end
    render json: builders.target!
  end

  def api51
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    shop = Shop.new
    builder = Jbuilder.new do |json|
      json.shop shop.to_jbuilder
    end
    render json: builder.target!
  end

  def api52
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    shop = Shop.new
    shop.attributes = {
        group_id: params[:group_id],
        admin_id: params[:admin_id],
        name: params[:name],
        name_kana: params[:name_kana],
        contract_person: params[:contract_person],
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
        service: params[:service],
        room_count: params[:room_count],
        seat_count: params[:seat_count],
        images: params[:images],
        way_images: params[:way_images]
    }
    if params[:tags].present?
      params[:tags].each do |key,val|
        shop.tag_list.add(val["name"])
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

  def api53
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    shop = Shop.find_by(id: params[:id])
    builder = Jbuilder.new do |json|
      json.shop shop.to_jbuilder
    end
    render json: builder.target!

  end
  def api54
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    shop = Shop.find_by(id: params[:id])
    shop.attributes = {
        group_id: params[:group_id],
        admin_id: params[:admin_id],
        name: params[:name],
        name_kana: params[:name_kana],
        contract_person: params[:contract_person],
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
        service: params[:service],
        opened_at: params[:opened_at],
        closed_at: params[:closed_at],
        room_count: params[:room_count],
        seat_count: params[:seat_count],
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

    if params[:way_images].present?
      params[:way_images].values.each do |image|
        shop.way_images.where(id: image[:id]).first.update(image: image[:url]) and next if image.present? && image[:id].present? && image[:id] != 'null'
        shop.way_images << ImageType::ShopWay.new(image: image[:url]) if image[:url] != 'null'
      end
    end

    if params[:tags].present?
      params[:tags].each do |key,val|
        shop.tag_list.add(val["name"])
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

  def api55
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    shop = Shop.find_by(id: params[:id])
    render_failed(4, t('admin.error.no_shop')) and return unless shop
    shop.deleted_at = shop && shop.deleted_at ? nil : Time.zone.now

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

  #top page
  def api56
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    reviews = Review.where(is_displayed: false).order('id desc').limit(10)
    contacts = Contact.order('id desc').limit(10)
    shop_count = Shop.where(deleted_at: nil).count
    user_count = User.where(deleted_at: nil).count
    now = Time.zone.now
    from = now.beginning_of_day
    to = now.end_of_day
    last_month = now.prev_month
    last_month_from = last_month.beginning_of_month
    last_month_to = last_month.end_of_month
    todays_review_count = Review.where(created_at: from...to).count
    todays_contact_count = Contact.where(created_at: from...to).count

    last_month_review_count = Review.where(created_at: last_month_from...last_month_to).count
    last_month_contact_count = Contact.where(created_at: last_month_from...last_month_to).count

    builders = Jbuilder.new do |json|
      json.code 1
      json.reviews Review.to_jbuilders(reviews)
      json.contacts Contact.to_jbuilders(contacts)
      json.shop_count shop_count
      json.user_count user_count
      json.todays_review_count todays_review_count
      json.todays_contact_count todays_contact_count
      json.last_month_review_count last_month_review_count
      json.last_month_contact_count last_month_contact_count
    end
    render json: builders.target!
  end
  def api57
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    review = Review.find_by(id: params[:id])
    review.is_displayed = true

    if review.save
      reviews = Review.where(is_displayed: false).limit(10)
      builders = Jbuilder.new do |json|
        json.code 1
        json.reviews Review.to_jbuilders(reviews)
      end
    end
    render json: builders.target!
  end

  def api58
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    invoices = Invoice.all
    total = invoices.count
    invoices = invoices.page(page).per(limit) if invoices.present?

    builders = Jbuilder.new do |json|
      json.code 1
      json.invoices Invoice.to_jbuilders(invoices)
      json.total total
    end
    render json: builders.target!
  end

  def api59
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    invoice = Invoice.find_by(id: params[:id])
    builder = Jbuilder.new do |json|
      json.invoice invoice.to_jbuilder
    end
    render json: builder.target!
  end

  def api60
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    invoice = Invoice.new
    builder = Jbuilder.new do |json|
      json.invoice invoice.to_jbuilder
    end
    render json: builder.target!
  end

  def api61
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    invoice = Invoice.new
    invoice.attributes = {
        shop_id: params[:shop_id],
        admin_id: params[:admin_id],
        period_from: params[:period_from],
        period_to: params[:period_to],
        due_date: params[:due_date],
        issued_at: params[:issued_at],
        paid_at: params[:paid_at],
        note: params[:note]
    }

    if invoice.save
      builder = Jbuilder.new do |json|
        json.invoice invoice.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors invoice.errors.full_messages
      end
    end
    render json: builder.target!
  end

  def api62
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    invoice = Invoice.find_by(id: params[:id])
    invoice.attributes = {
        shop_id: params[:shop_id],
        admin_id: params[:admin_id],
        period_from: params[:period_from],
        period_to: params[:period_to],
        due_date: params[:due_date],
        issued_at: params[:issued_at],
        paid_at: params[:paid_at],
        note: params[:note]
    }

    if invoice.save
      builder = Jbuilder.new do |json|
        json.invoice invoice.to_jbuilder
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors invoice.errors.full_messages
      end
    end
    render json: builder.target!
  end

  def api63
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    invoice_detail = InvoiceDetail.find_by(id: params[:id]) if params[:id]
    invoice_detail = InvoiceDetail.new unless invoice_detail
    invoice_detail.attributes ={
        invoice_id: params[:invoice_id],
        name: params[:name],
        quantilty: params[:quantilty],
        unit_price: params[:unit_price],
        category: params[:category],
        tax_rate: params[:tax_rate]
    }


    if invoice_detail.save
      sub_amount = 0
      total = 0
      invoice = Invoice.find_by(id: invoice_detail.invoice_id)
      sub_amount = InvoiceDetail.put_total_sub_amount(invoice.invoice_details)
      total = InvoiceDetail.put_total_amount(invoice.invoice_details)
      invoice.attributes={sub_amount: sub_amount,total: total}
      invoice.save

      builder = Jbuilder.new do |json|
        json.invoice_details InvoiceDetail.to_jbuilders(InvoiceDetail.where(invoice_id: invoice_detail.invoice_id))
        json.code 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors invoice_detail.errors.full_messages
      end
    end
    render json: builder.target!
  end

  def api64
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    invoice_detail = InvoiceDetail.find_by(id: params[:id])

    invoice_detail.delete if invoice_detail.present?

    sub_amount = 0
    total = 0
    invoice = Invoice.find_by(id: params[:id])
    sub_amount = InvoiceDetail.put_total_sub_amount(invoice.invoice_details)
    total = InvoiceDetail.put_total_amount(invoice.invoice_details)
    invoice.attributes={sub_amount: sub_amount,total: total}
    invoice.save

    builder = Jbuilder.new do |json|
      json.invoice_details InvoiceDetail.to_jbuilders(InvoiceDetail.where(invoice_id: invoice_detail.invoice_id))
      json.code 1
    end
    render json: builder.target!
  end
  def api65
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?

    ids = params[:ids].split(',')
    invoices = Invoice.where(id: ids)

    builders = Jbuilder.new do |json|
      json.invoices Invoice.to_jbuilders(invoices)
      json.code 1
    end
    render json: builders.target!
  end

  def api66
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?

    now = Time.zone.now
    dates = []

    basic_sql = "from (select ('#{now.beginning_of_month.strftime('%Y-%m-%d')}') + interval (id - 1) day date from page_views limit 30) d"
    select_sql = "select d.date "
    date_sql = select_sql + basic_sql
    con = ActiveRecord::Base.connection
    result = con.select_all(date_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('x')
    dates << make_result

    select_sql = "select (select count(1) from contacts where DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    pvcount_sql = select_sql + basic_sql
    result = con.select_all(pvcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('contact_count')
    dates << make_result

    select_sql = "select (select count(1) from reviews where DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    suportcount_sql = select_sql + basic_sql
    result = con.select_all(suportcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('review_count')
    dates << make_result

    render json: {code: 1,chart_date: dates}
  end
  def api67
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    users = User.where(shop_id: params[:shop_id]) if params[:shop_id]

    builders = Jbuilder.new do |json|
      json.users User.to_jbuilders(users)
      json.code 1
    end
    render json: builders.target!
  end

  def api68
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    users = User.where(job_type: params[:job_type], deleted_at: nil) if params[:job_type]

    builders = Jbuilder.new do |json|
      json.users User.to_jbuilders(users)
      json.code 1
    end
    render json: builders.target!
  end

  def api69
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    shops = Shop.where(job_type: params[:job_type], deleted_at: nil) if params[:job_type]

    builders = Jbuilder.new do |json|
      json.shops Shop.to_jbuilders(shops)
      json.code 1
    end
    render json: builders.target!
  end

  def api70
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    admins = Admin.all

    builders = Jbuilder.new do |json|
      json.admins admins
      json.code 1
    end
    render json: builders.target!
  end
  def api71
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    admin = Admin.find_by(id: params[:id])

    builder = Jbuilder.new do |json|
      json.admin admin
      json.code 1
    end
    render json: builder.target!
  end

  def api72
    render_failed(4, t('admin.error.no_login')) and return unless admin_signed_in?
    admin = Admin.find_by(id: params[:id]) if params[:id]
    admin = Admin.new unless admin
    admin.name = params[:name]
    admin.email = params[:email]
    admin.password = params[:password] if params[:password]
    admin.save!
    builder = Jbuilder.new do |json|
      json.admin admin
      json.code 1
    end
    render json: builder.target!
  end


end
