class Api::AdminController < ApiController

  def api1
    email = params[:email]
    password = params[:password]
    raise 'email or password is missing.' if email.blank? || password.blank?
    admin = Admin.where(:email => params[:email]).first
    render_failed(2,t('errors.messages.object_not_found',:name => params[:email])) and return unless admin && admin.valid_password?(params[:password])
    sign_in admin
    builder = Jbuilder.new do |json|
      json.code 1
      json.admin admin.name
    end
    render json: builder.target!
  end

  def api2
    render_failed(102, 'ログインが必要です(needs login)', response_type = 'json') and return unless admin_signed_in?
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    total = Group.count
    groups = Group.all
    groups = groups.page(page).per(limit) if groups.present?
    builders = Jbuilder.new do |json|
      json.groups Group.to_jbuilders(groups)
      json.total total
    end
    render json: builders.target!
  end

  def api3
    group = Group.new
    builder = Jbuilder.new do |json|
      json.group group.to_jbuilder
    end
    render json: builder.target!
  end

  def api4
    group = Group.new
    group.attributes = {
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
      chip: params[:chip],
      note: params[:note],
      is_smoked: params[:is_smoked],
      opened_at: params[:opened_at],
      closed_at: params[:closed_at],
      budget_yen: params[:budget_yen],
      budget_vnd: params[:budget_vnd],
      budget_usd: params[:budget_usd],
      images: params[:images]
    }
    params[:tags].each do |key,val|
      group.tag_list.add(val["text"])
    end

    if group.save
      builder = Jbuilder.new do |json|
        json.group group.to_jbuilder
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors group.errors.full_messages
        json.status 0
      end
    end
    render json: builder.target!
  end

  def api5
    render_failed(102, 'ログインが必要です(needs login)', response_type = 'json') and return unless admin_signed_in?
    group = Group.find_by(id: params[:id])
    builder = Jbuilder.new do |json|
      json.group group.to_jbuilder
    end
    render json: builder.target!

  end
  def api6
    render_failed(102, 'ログインが必要です(needs login)', response_type = 'json') and return unless admin_signed_in?
    group = Group.find_by(id: params[:id])
    group.attributes = {
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
        chip: params[:chip],
        note: params[:note],
        is_smoked: params[:is_smoked],
        opened_at: params[:opened_at],
        closed_at: params[:closed_at],
        budget_yen: params[:budget_yen],
        budget_vnd: params[:budget_vnd],
        budget_usd: params[:budget_usd]

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
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors group.errors.full_messages
        json.status 0
      end
    end
    render json: builder.target!
  end
  def api8
    render_failed(102, 'ログインが必要です(needs login)', response_type = 'json') and return unless admin_signed_in?
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 20
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1

    users = User.all
    users = users.keyword_filter(params[:keyword]) if params[:keyword]
    users = users.job_type_filter(params[:job_type]) if params[:job_type]
    users = users.sex_filter(params[:sex]) if params[:sex]
    total = users.count
    users = users.page(page).per(limit) if users.present?
    builders = Jbuilder.new do |json|
      json.users User.to_jbuilders(users)
      json.total total
    end
    render json: builders.target!
  end

  def api9
    render_failed(102, 'ログインが必要です(needs login)', response_type = 'json') and return unless admin_signed_in?
    user = User.find_by(id: params[:id])
    builders = Jbuilder.new do |json|
      json.user user.to_jbuilder
    end
    render json: builders.target!
  end

  def api10
    user = User.new
    builder = Jbuilder.new do |json|
      json.user user.to_jbuilder
    end
    render json: builder.target!
  end

  def api11
    user = User.new
    blog = BlogType::Introduction.new
    blog.subject_type = "User"


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
    # user.user_profiles << ProfileType::Vn.new(
    #     like_boy: params[:vn]['like_boy'],
    #     like_girl: params[:vn]['like_girl'],
    #     my_color: params[:vn]['my_color'],
    #     happy_word: params[:vn]['happy_word'],
    #     gesture: params[:vn]['gesture'],
    #     attracted: params[:vn]['attracted'],
    #     love_situation: params[:vn]['love_situation'],
    #     first_love: params[:vn]['first_love'],
    #     how_to_approach: params[:vn]['how_to_approach'],
    #     how_to_holiday: params[:vn]['how_to_holiday'],
    #     idea_couple: params[:vn]['idea_couple'],
    #     take_one: params[:vn]['take_one'],
    #     like_word: params[:vn]['like_word'],
    #     like_music: params[:vn]['like_music'],
    #     like_place: params[:vn]['like_place'],
    #     like_food: params[:vn]['like_food'],
    #     like_drink: params[:vn]['like_drink'],
    #     like_sports: params[:vn]['like_sports'],
    #     best_feature: params[:vn]['best_feature'],
    #     love_tips: params[:vn]['love_tips'],
    #     character: params[:vn]['character'],
    #     hobby: params[:vn]['hobby'],
    #     skill: params[:vn]['skill'],
    #     habit: params[:vn]['habit'],
    #     brag: params[:vn]['brag'],
    #     my_fad: params[:vn]['my_fad'],
    #     secret_talk: params[:vn]['secret_talk'],
    #     dream: params[:vn]['dream'],
    #     go: params[:vn]['go'],
    #     want: params[:vn]['want'],
    #     do_something: params[:vn]['do_something'],
    #     happy_event: params[:vn]['happy_event'],
    #     painful_event: params[:vn]['painful_event'],
    #     previous_life: params[:vn]['previous_life'],
    #     admire_person: params[:vn]['admire_person'],
    #     interview: params[:vn]['interview']
    # )
    # user.user_profiles << ProfileType::En.new(
    #     like_boy: params[:en]['like_boy'],
    #     like_girl: params[:en]['like_girl'],
    #     my_color: params[:en]['my_color'],
    #     happy_word: params[:en]['happy_word'],
    #     gesture: params[:en]['gesture'],
    #     attracted: params[:en]['attracted'],
    #     love_situation: params[:en]['love_situation'],
    #     first_love: params[:en]['first_love'],
    #     how_to_approach: params[:en]['how_to_approach'],
    #     how_to_holiday: params[:en]['how_to_holiday'],
    #     idea_couple: params[:en]['idea_couple'],
    #     take_one: params[:en]['take_one'],
    #     like_word: params[:en]['like_word'],
    #     like_music: params[:en]['like_music'],
    #     like_place: params[:en]['like_place'],
    #     like_food: params[:en]['like_food'],
    #     like_drink: params[:en]['like_drink'],
    #     like_sports: params[:en]['like_sports'],
    #     best_feature: params[:en]['best_feature'],
    #     love_tips: params[:en]['love_tips'],
    #     character: params[:en]['character'],
    #     hobby: params[:en]['hobby'],
    #     skill: params[:en]['skill'],
    #     habit: params[:en]['habit'],
    #     brag: params[:en]['brag'],
    #     my_fad: params[:en]['my_fad'],
    #     secret_talk: params[:en]['secret_talk'],
    #     dream: params[:en]['dream'],
    #     go: params[:en]['go'],
    #     want: params[:en]['want'],
    #     do_something: params[:en]['do_something'],
    #     happy_event: params[:en]['happy_event'],
    #     painful_event: params[:en]['painful_event'],
    #     previous_life: params[:en]['previous_life'],
    #     admire_person: params[:en]['admire_person'],
    #     interview: params[:en]['interview']
    # )

    user.attributes = {
        name: params[:name],
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
        images: params[:images]
    }
    if params[:tags]
      params[:tags].each do |key,val|
        user.tag_list.add(val["text"])
      end
    end

    if user.save!
      blog.auto_save_user(user)
      builder = Jbuilder.new do |json|
        json.user user.to_jbuilder
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors user.errors.full_messages
        json.status 0
      end
    end
    render json: builder.target!

  end

  def api12
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
  def api13
    render_failed(102, 'ログインが必要です(needs login)', response_type = 'json') and return unless admin_signed_in?
    user = User.find_by(id: params[:id])
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
    # user.vn_profile.attributes = {
    #     like_boy: params[:vn]['like_boy'],
    #     like_girl: params[:vn]['like_girl'],
    #     my_color: params[:vn]['my_color'],
    #     happy_word: params[:vn]['happy_word'],
    #     gesture: params[:vn]['gesture'],
    #     attracted: params[:vn]['attracted'],
    #     love_situation: params[:vn]['love_situation'],
    #     first_love: params[:vn]['first_love'],
    #     how_to_approach: params[:vn]['how_to_approach'],
    #     how_to_holiday: params[:vn]['how_to_holiday'],
    #     idea_couple: params[:vn]['idea_couple'],
    #     take_one: params[:vn]['take_one'],
    #     like_word: params[:vn]['like_word'],
    #     like_music: params[:vn]['like_music'],
    #     like_place: params[:vn]['like_place'],
    #     like_food: params[:vn]['like_food'],
    #     like_drink: params[:vn]['like_drink'],
    #     like_sports: params[:vn]['like_sports'],
    #     best_feature: params[:vn]['best_feature'],
    #     love_tips: params[:vn]['love_tips'],
    #     character: params[:vn]['character'],
    #     hobby: params[:vn]['hobby'],
    #     skill: params[:vn]['skill'],
    #     habit: params[:vn]['habit'],
    #     brag: params[:vn]['brag'],
    #     my_fad: params[:vn]['my_fad'],
    #     secret_talk: params[:vn]['secret_talk'],
    #     dream: params[:vn]['dream'],
    #     go: params[:vn]['go'],
    #     want: params[:vn]['want'],
    #     do_something: params[:vn]['do_something'],
    #     happy_event: params[:vn]['happy_event'],
    #     painful_event: params[:vn]['painful_event'],
    #     previous_life: params[:vn]['previous_life'],
    #     admire_person: params[:vn]['admire_person'],
    #     interview: params[:vn]['interview']
    # }
    # user.en_profile.attributes = {
    #     like_boy: params[:en]['like_boy'],
    #     like_girl: params[:en]['like_girl'],
    #     my_color: params[:en]['my_color'],
    #     happy_word: params[:en]['happy_word'],
    #     gesture: params[:en]['gesture'],
    #     attracted: params[:en]['attracted'],
    #     love_situation: params[:en]['love_situation'],
    #     first_love: params[:en]['first_love'],
    #     how_to_approach: params[:en]['how_to_approach'],
    #     how_to_holiday: params[:en]['how_to_holiday'],
    #     idea_couple: params[:en]['idea_couple'],
    #     take_one: params[:en]['take_one'],
    #     like_word: params[:en]['like_word'],
    #     like_music: params[:en]['like_music'],
    #     like_place: params[:en]['like_place'],
    #     like_food: params[:en]['like_food'],
    #     like_drink: params[:en]['like_drink'],
    #     like_sports: params[:en]['like_sports'],
    #     best_feature: params[:en]['best_feature'],
    #     love_tips: params[:en]['love_tips'],
    #     character: params[:en]['character'],
    #     hobby: params[:en]['hobby'],
    #     skill: params[:en]['skill'],
    #     habit: params[:en]['habit'],
    #     brag: params[:en]['brag'],
    #     my_fad: params[:en]['my_fad'],
    #     secret_talk: params[:en]['secret_talk'],
    #     dream: params[:en]['dream'],
    #     go: params[:en]['go'],
    #     want: params[:en]['want'],
    #     do_something: params[:en]['do_something'],
    #     happy_event: params[:en]['happy_event'],
    #     painful_event: params[:en]['painful_event'],
    #     previous_life: params[:en]['previous_life'],
    #     admire_person: params[:en]['admire_person'],
    #     interview: params[:en]['interview']
    # }
    user.attributes = {
        name: params[:name],
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
    }

    if params[:images].present?
      params[:images].values.each do |image|
        user.images.where(id: image[:id]).first.update(image: image[:url]) and next if image.present? && image[:id].present? && image[:id] != 'null'
        image = user.images.new
        image.image = image[:url] and image.save! if image[:url] != 'null'
      end
    end
    p "========================"
    p params[:tags]
    p "========================"


    if params[:tags]
      params[:tags].each do |key,val|
        user.tag_list.add(val["text"])
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
        json.status 0
      end
    end
    render json: builder.target!
  end
  def api15
    users = User.all
    groups = Group.all
    builders = Jbuilder.new do |json|
      json.users User.to_jbuilders(users)
      json.groups Group.to_jbuilders(groups)
    end
    render json: builders.target!
  end

  def api16
    pickup = Pickup.new
    builders = Jbuilder.new do |json|
      json.pickup pickup.to_jbuilder
    end
    render json: builders.target!
  end

  def api17
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
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors pickup.errors.full_messages
        json.status 0
      end
    end
    render json: builder.target!
  end
  def api18
    render_failed(102, 'ログインが必要です(needs login)', response_type = 'json') and return unless admin_signed_in?
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

  def api19
    contact = Contact.new
    builders = Jbuilder.new do |json|
      json.contact contact.to_jbuilder
    end
    render json: builders.target!
  end
  def api20
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
    builders = Jbuilder.new do |json|
      json.contact contact.to_jbuilder
    end
    render json: builders.target!
  end

  def api21
    contact = Contact.find_by(id: params[:id])
    builders = Jbuilder.new do |json|
      json.contact contact.to_jbuilder
    end
    render json: builders.target!
  end

  def api22
    contact = Contact.find_by(id: params[:id])
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
    builders = Jbuilder.new do |json|
      json.contact contact.to_jbuilder
    end
    render json: builders.target!
  end


  def api23
    pickup = Pickup.find_by(id: params[:id])
    builder = Jbuilder.new do |json|
      json.pickup pickup.to_jbuilder
      json.status 1
    end
    render json: builder.target!
  end
  def api24
    pickup = Pickup.find_by(id: params[:id])
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
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors pickup.errors.full_messages
        json.status 0
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
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors banner.errors.full_messages
        json.status 0
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
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors banner.errors.full_messages
        json.status 0
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
    blog = Blog.new
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
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors blog.errors.full_messages
        json.status 0
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
        json.status 1
      end
    else
      builder = Jbuilder.new do |json|
        json.errors blog.errors.full_messages
        json.status 0
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

    select_sql = "select (select count(1) from page_views where type = 'PageViewType::GroupDetail' and subject_type = 'Group' and subject_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    pvcount_sql = select_sql + basic_sql
    result = con.select_all(pvcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('pv_count')
    dates << make_result

    select_sql = "select (select count(1) from posts where type = 'PostType::Support' and receiver_type = 'Group' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    suportcount_sql = select_sql + basic_sql
    result = con.select_all(suportcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('support_count')
    dates << make_result

    select_sql = "select (select count(1) from posts where type = 'PostType::Favorite' and receiver_type = 'Group' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    favoritecount_sql = select_sql + basic_sql
    result = con.select_all(favoritecount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('favoritecount_count')
    dates << make_result

    select_sql = "select (select count(1) from contacts where type = 'ContactType::GroupDetail' and subject_type = 'Group' and subject_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    contacttcount_sql = select_sql + basic_sql
    result = con.select_all(contacttcount_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('contacttcount_count')
    dates << make_result

    select_sql = "select (select count(1) from reviews where type = 'ReviewType::Group' and receiver_type = 'Group' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m-%d') = d.date) "
    review_sql = select_sql + basic_sql
    result = con.select_all(review_sql)
    make_result = result.rows.map{|r| r[0]}
    make_result.unshift('review_count')
    dates << make_result

    result = con.select_all("select count(1) from page_views where type = 'PageViewType::GroupDetail' and subject_type = 'Group' and subject_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_pv_count = result.rows[0][0]

    result = con.select_all("select count(1) from posts where type = 'PostType::Support' and receiver_type = 'Group' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_support_count = result.rows[0][0]

    result = con.select_all("select count(1) from posts where type = 'PostType::Favorite' and receiver_type = 'Group' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_favorite_count = result.rows[0][0]

    result = con.select_all("select count(1) from contacts where type = 'ContactType::GroupDetail' and subject_type = 'Group' and subject_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
    monthly_contact_count = result.rows[0][0]

    result = con.select_all("select count(1) from reviews where type = 'ReviewType::Group' and receiver_type = 'Group' and receiver_id = #{group_id} and DATE_FORMAT(created_at, '%Y-%m') = '#{now.beginning_of_month.strftime('%Y-%m')}'")
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
    group = Group.find_by(id: params[:id])
    builders = Jbuilder.new do |json|
      json.contacts group.contacts ? Contact.to_jbuilders(group.contacts.order('id desc')) : nil
      json.reviews Review.to_jbuilders(group.reviews.order('id desc'))
    end
    render json: builders.target!
  end


end
